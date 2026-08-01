import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../domain/library_models.dart' as domain;
import '../infrastructure/database/media_library_database.dart';
import '../infrastructure/filesystem/directory_enumerator.dart';
import '../infrastructure/metadata/basic_metadata_reader.dart';

final class LibraryScanProgress {
  const LibraryScanProgress({
    required this.rootId,
    required this.status,
    required this.generation,
    this.discoveredCount = 0,
    this.insertedCount = 0,
    this.updatedCount = 0,
    this.unchangedCount = 0,
    this.missingCount = 0,
    this.failedCount = 0,
    this.message,
  });
  final String rootId;
  final domain.ScanStatus status;
  final int generation;
  final int discoveredCount;
  final int insertedCount;
  final int updatedCount;
  final int unchangedCount;
  final int missingCount;
  final int failedCount;
  final String? message;
}

final class ScanCancellationToken {
  bool _cancelled = false;
  bool get isCancelled => _cancelled;
  void cancel() => _cancelled = true;
}

/// Owns only transient scan state. Persistent library rows remain Drift-owned.
final class LibraryScanCoordinator {
  LibraryScanCoordinator(
    this._database, {
    DirectoryEnumerator? enumerator,
    BasicMetadataReader? metadataReader,
  }) : _enumerator = enumerator ?? DirectoryEnumerator(),
       _metadataReader = metadataReader ?? const BasicMetadataReader();

  final MediaLibraryDatabase _database;
  final DirectoryEnumerator _enumerator;
  final BasicMetadataReader _metadataReader;
  final _progress = StreamController<LibraryScanProgress>.broadcast();
  final _active = <String, ScanCancellationToken>{};
  static const _uuid = Uuid();

  Stream<LibraryScanProgress> get progress => _progress.stream;

  ScanCancellationToken scan(String rootPublicId) {
    if (_active.containsKey(rootPublicId)) {
      throw StateError('A scan is already active for root $rootPublicId');
    }
    final token = ScanCancellationToken();
    _active[rootPublicId] = token;
    unawaited(_run(rootPublicId, token));
    return token;
  }

  Future<void> scanAndWait(
    String rootPublicId, {
    ScanCancellationToken? token,
  }) async {
    final actualToken = token ?? ScanCancellationToken();
    if (_active.containsKey(rootPublicId)) {
      throw StateError('A scan is already active for root $rootPublicId');
    }
    _active[rootPublicId] = actualToken;
    await _run(rootPublicId, actualToken);
  }

  Future<void> _run(String rootPublicId, ScanCancellationToken token) async {
    LibraryRoot? root;
    int generation = 0;
    int? scanRunId;
    var discovered = 0;
    var inserted = 0;
    var updated = 0;
    var unchanged = 0;
    var failures = 0;
    try {
      root = await (_database.select(
        _database.libraryRoots,
      )..where((r) => r.publicId.equals(rootPublicId))).getSingle();
      generation = root.scanGeneration + 1;
      final now = DateTime.now().toUtc();
      scanRunId = await _database
          .into(_database.scanRuns)
          .insert(
            ScanRunsCompanion.insert(
              publicId: _uuid.v7(),
              rootId: root.rowId,
              generation: generation,
              status: 'enumerating',
              startedAt: now,
            ),
          );
      await (_database.update(
        _database.libraryRoots,
      )..where((r) => r.rowId.equals(root!.rowId))).write(
        LibraryRootsCompanion(
          scanGeneration: Value(generation),
          lastScanStartedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      _emit(rootPublicId, domain.ScanStatus.enumerating, generation);
      await for (final file in _enumerator.enumerate(
        root: root.locator,
        recursive: root.recursive,
      )) {
        if (token.isCancelled) throw _ScanCancelled();
        discovered++;
        final result = await _upsertFile(root, generation, file);
        inserted += result.inserted;
        updated += result.updated;
        unchanged += result.unchanged;
        _emit(
          rootPublicId,
          domain.ScanStatus.processing,
          generation,
          discovered: discovered,
          inserted: inserted,
          updated: updated,
          unchanged: unchanged,
        );
      }
      if (token.isCancelled) throw _ScanCancelled();
      // Missing Finalization executes only after a complete, uncancelled enumeration.
      final finalizedAt = DateTime.now().toUtc();
      final missing =
          await (_database.update(_database.mediaFiles)..where(
                (file) =>
                    file.rootId.equals(root!.rowId) &
                    file.lastSeenGeneration.isSmallerThanValue(generation) &
                    file.availabilityState.equals('available'),
              ))
              .write(
                MediaFilesCompanion(
                  availabilityState: const Value('missing'),
                  missingSince: Value(finalizedAt),
                  updatedAt: Value(finalizedAt),
                ),
              );
      await (_database.update(
        _database.scanRuns,
      )..where((run) => run.rowId.equals(scanRunId!))).write(
        ScanRunsCompanion(
          status: const Value('completed'),
          finishedAt: Value(finalizedAt),
          discoveredCount: Value(discovered),
          insertedCount: Value(inserted),
          updatedCount: Value(updated),
          unchangedCount: Value(unchanged),
          missingCount: Value(missing),
          failedCount: Value(failures),
        ),
      );
      await (_database.update(
        _database.libraryRoots,
      )..where((r) => r.rowId.equals(root!.rowId))).write(
        LibraryRootsCompanion(
          lastScanCompletedAt: Value(finalizedAt),
          updatedAt: Value(finalizedAt),
        ),
      );
      _emit(
        rootPublicId,
        domain.ScanStatus.completed,
        generation,
        discovered: discovered,
        inserted: inserted,
        updated: updated,
        unchanged: unchanged,
        missing: missing,
      );
    } on _ScanCancelled {
      if (scanRunId != null) {
        await _finishAborted(
          scanRunId,
          'cancelled',
          discovered,
          inserted,
          updated,
          unchanged,
          failures,
        );
      }
      _emit(
        rootPublicId,
        domain.ScanStatus.cancelled,
        generation,
        discovered: discovered,
        inserted: inserted,
        updated: updated,
        unchanged: unchanged,
      );
    } on FileSystemException catch (error) {
      failures++;
      if (scanRunId != null) {
        await _finishAborted(
          scanRunId,
          'failed',
          discovered,
          inserted,
          updated,
          unchanged,
          failures,
          error.message,
        );
      }
      _emit(
        rootPublicId,
        domain.ScanStatus.failed,
        generation,
        discovered: discovered,
        inserted: inserted,
        updated: updated,
        unchanged: unchanged,
        failed: failures,
        message: error.message,
      );
    } catch (error) {
      failures++;
      if (scanRunId != null) {
        await _finishAborted(
          scanRunId,
          'failed',
          discovered,
          inserted,
          updated,
          unchanged,
          failures,
          error.toString(),
        );
      }
      _emit(
        rootPublicId,
        domain.ScanStatus.failed,
        generation,
        discovered: discovered,
        inserted: inserted,
        updated: updated,
        unchanged: unchanged,
        failed: failures,
        message: error.toString(),
      );
    } finally {
      _active.remove(rootPublicId);
    }
  }

  Future<_UpsertResult> _upsertFile(
    LibraryRoot root,
    int generation,
    EnumeratedAudioFile file,
  ) async {
    final existing =
        await (_database.select(_database.mediaFiles)..where(
              (row) =>
                  row.rootId.equals(root.rowId) &
                  row.locatorKey.equals(file.locatorKey),
            ))
            .getSingleOrNull();
    final now = DateTime.now().toUtc();
    if (existing == null) {
      final mediaFileId = await _database
          .into(_database.mediaFiles)
          .insert(
            MediaFilesCompanion.insert(
              publicId: _uuid.v7(),
              rootId: root.rowId,
              locator: file.locator,
              locatorKey: file.locatorKey,
              relativePath: file.relativePath,
              fileName: file.fileName,
              extension: file.extension,
              sizeBytes: file.stat.size,
              modifiedAtMicros: file.stat.modified
                  .toUtc()
                  .microsecondsSinceEpoch,
              availabilityState: 'available',
              metadataState: 'pending',
              lastSeenGeneration: generation,
              lastSeenAt: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
      final metadata = _metadataReader.read(file);
      final trackPublicId = _uuid.v7();
      final trackId = await _database
          .into(_database.tracks)
          .insert(
            TracksCompanion.insert(
              publicId: trackPublicId,
              mediaFileId: mediaFileId,
              title: metadata.title,
              sortTitle: metadata.sortTitle,
              searchText: metadata.searchText,
              metadataSource: Value(metadata.source),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await _syncFts(trackId, trackPublicId, metadata, file);
      await (_database.update(_database.mediaFiles)
            ..where((row) => row.rowId.equals(mediaFileId)))
          .write(const MediaFilesCompanion(metadataState: Value('ready')));
      return const _UpsertResult(inserted: 1);
    }
    final changed =
        existing.sizeBytes != file.stat.size ||
        existing.modifiedAtMicros !=
            file.stat.modified.toUtc().microsecondsSinceEpoch;
    await (_database.update(
      _database.mediaFiles,
    )..where((row) => row.rowId.equals(existing.rowId))).write(
      MediaFilesCompanion(
        locator: Value(file.locator),
        relativePath: Value(file.relativePath),
        fileName: Value(file.fileName),
        extension: Value(file.extension),
        sizeBytes: Value(file.stat.size),
        modifiedAtMicros: Value(
          file.stat.modified.toUtc().microsecondsSinceEpoch,
        ),
        availabilityState: const Value('available'),
        lastSeenGeneration: Value(generation),
        lastSeenAt: Value(now),
        missingSince: const Value(null),
        updatedAt: Value(now),
      ),
    );
    if (changed) {
      final metadata = _metadataReader.read(file);
      final track =
          await (_database.select(_database.tracks)
                ..where((track) => track.mediaFileId.equals(existing.rowId)))
              .getSingleOrNull();
      if (track != null) {
        await (_database.update(
          _database.tracks,
        )..where((row) => row.rowId.equals(track.rowId))).write(
          TracksCompanion(
            title: Value(metadata.title),
            sortTitle: Value(metadata.sortTitle),
            searchText: Value(metadata.searchText),
            metadataSource: Value(metadata.source),
            metadataRevision: Value(track.metadataRevision + 1),
            updatedAt: Value(now),
          ),
        );
        await _syncFts(track.rowId, track.publicId, metadata, file);
      }
    }
    return changed
        ? const _UpsertResult(updated: 1)
        : const _UpsertResult(unchanged: 1);
  }

  Future<void> _syncFts(
    int trackId,
    String trackPublicId,
    BasicTrackMetadata metadata,
    EnumeratedAudioFile file,
  ) async {
    await _database.deleteTrackSearch(trackId);
    await _database.insertTrackSearch(
      trackId,
      trackPublicId,
      metadata.title,
      null,
      null,
      file.fileName,
    );
  }

  Future<void> _finishAborted(
    int scanRunId,
    String status,
    int discovered,
    int inserted,
    int updated,
    int unchanged,
    int failures, [
    String? message,
  ]) =>
      (_database.update(
        _database.scanRuns,
      )..where((run) => run.rowId.equals(scanRunId))).write(
        ScanRunsCompanion(
          status: Value(status),
          finishedAt: Value(DateTime.now().toUtc()),
          discoveredCount: Value(discovered),
          insertedCount: Value(inserted),
          updatedCount: Value(updated),
          unchangedCount: Value(unchanged),
          failedCount: Value(failures),
          failureMessage: Value(message),
        ),
      );

  void _emit(
    String rootId,
    domain.ScanStatus status,
    int generation, {
    int discovered = 0,
    int inserted = 0,
    int updated = 0,
    int unchanged = 0,
    int missing = 0,
    int failed = 0,
    String? message,
  }) => _progress.add(
    LibraryScanProgress(
      rootId: rootId,
      status: status,
      generation: generation,
      discoveredCount: discovered,
      insertedCount: inserted,
      updatedCount: updated,
      unchangedCount: unchanged,
      missingCount: missing,
      failedCount: failed,
      message: message,
    ),
  );

  Future<void> close() => _progress.close();
}

final class _UpsertResult {
  const _UpsertResult({
    this.inserted = 0,
    this.updated = 0,
    this.unchanged = 0,
  });
  final int inserted;
  final int updated;
  final int unchanged;
}

final class _ScanCancelled implements Exception {}
