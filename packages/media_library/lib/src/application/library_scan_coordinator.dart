import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../domain/library_models.dart' as domain;
import '../infrastructure/database/media_library_database.dart';
import '../infrastructure/filesystem/directory_enumerator.dart';
import '../infrastructure/metadata/basic_metadata_reader.dart';
import '../infrastructure/metadata/audio_metadata_reader_adapter.dart';

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

final class LibraryRootScanResult {
  const LibraryRootScanResult({
    required this.rootId,
    required this.status,
    this.message,
  });
  final String rootId;
  final domain.ScanStatus status;
  final String? message;
}

final class ScanAllResult {
  const ScanAllResult({required this.results, required this.cancelled});
  final List<LibraryRootScanResult> results;
  final bool cancelled;
}

/// Owns only transient scan state. Persistent library rows remain Drift-owned.
final class LibraryScanCoordinator {
  LibraryScanCoordinator(
    this._database, {
    AudioFileEnumerator? enumerator,
    TrackMetadataReader? metadataReader,
  }) : _enumerator = enumerator ?? DirectoryEnumerator(),
       _metadataReader = metadataReader ?? AudioMetadataReaderAdapter();

  final MediaLibraryDatabase _database;
  final AudioFileEnumerator _enumerator;
  final TrackMetadataReader _metadataReader;
  final _progress = StreamController<LibraryScanProgress>.broadcast();
  final _active = <String, ScanCancellationToken>{};
  final _runs = <String, Future<void>>{};
  String? _activeRootId;
  String? _cancellingRootId;
  final _latestProgress = <String, LibraryScanProgress>{};
  bool _closed = false;
  static const _uuid = Uuid();

  Stream<LibraryScanProgress> get progress => _progress.stream;

  /// Process-local state. Final results remain persisted in the scan-runs table.
  domain.LibraryRootScanState? rootState(String rootId) {
    if (_activeRootId == rootId) {
      return _cancellingRootId == rootId
          ? domain.LibraryRootScanState.cancelling
          : domain.LibraryRootScanState.scanning;
    }
    return switch (_latestProgress[rootId]?.status) {
      domain.ScanStatus.failed => domain.LibraryRootScanState.failed,
      domain.ScanStatus.cancelled => domain.LibraryRootScanState.cancelled,
      domain.ScanStatus.completed || domain.ScanStatus.completedWithIssues =>
        domain.LibraryRootScanState.completed,
      _ => null,
    };
  }

  ScanCancellationToken scan(String rootPublicId) {
    if (_closed) throw StateError('LibraryScanCoordinator is closed');
    if (_activeRootId != null) {
      throw StateError('A scan is already active for root $_activeRootId');
    }
    final token = ScanCancellationToken();
    _active[rootPublicId] = token;
    _activeRootId = rootPublicId;
    final run = _run(rootPublicId, token);
    _runs[rootPublicId] = run;
    unawaited(run.whenComplete(() => _runs.remove(rootPublicId)));
    return token;
  }

  Future<void> scanAndWait(
    String rootPublicId, {
    ScanCancellationToken? token,
  }) async {
    if (_closed) throw StateError('LibraryScanCoordinator is closed');
    final actualToken = token ?? ScanCancellationToken();
    if (_activeRootId != null) {
      throw StateError('A scan is already active for root $_activeRootId');
    }
    _active[rootPublicId] = actualToken;
    _activeRootId = rootPublicId;
    final run = _run(rootPublicId, actualToken);
    _runs[rootPublicId] = run;
    try {
      await run;
    } finally {
      _runs.remove(rootPublicId);
    }
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
      if (!root.enabled) throw StateError('Library root is disabled');
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
      final files = <EnumeratedAudioFile>[];
      await for (final file in _enumerator.enumerate(
        root: root.locator,
        recursive: root.recursive,
      )) {
        if (token.isCancelled) throw _ScanCancelled();
        files.add(file);
      }
      final repeatedFileIds = <String>{};
      final fileIdCounts = <String, int>{};
      for (final file in files) {
        final id = file.platformFileId;
        if (id != null) fileIdCounts[id] = (fileIdCounts[id] ?? 0) + 1;
      }
      fileIdCounts.forEach((id, count) {
        if (count > 1) repeatedFileIds.add(id);
      });
      for (final file in files) {
        if (token.isCancelled) throw _ScanCancelled();
        discovered++;
        final result = await _upsertFile(
          root,
          generation,
          file,
          allowPlatformIdentityMatch: !repeatedFileIds.contains(
            file.platformFileId,
          ),
        );
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
      _activeRootId = null;
      _cancellingRootId = null;
    }
  }

  Future<void> cancelActiveScan() async {
    final rootId = _activeRootId;
    if (rootId == null) return;
    _cancellingRootId = rootId;
    final previous = _latestProgress[rootId];
    if (previous != null) {
      _emit(rootId, previous.status, previous.generation);
    }
    _active[rootId]?.cancel();
    await _runs[rootId];
  }

  bool get hasActiveScan => _activeRootId != null;
  String? get activeRootId => _activeRootId;

  /// Stable, serial scan-all policy. A failed root never prevents later roots.
  Future<ScanAllResult> scanAllEnabledRoots() async {
    if (_activeRootId != null) {
      throw StateError('A scan is already active for root $_activeRootId');
    }
    final roots =
        await (_database.select(_database.libraryRoots)
              ..where((root) => root.enabled.equals(true))
              ..orderBy([(root) => OrderingTerm.asc(root.locatorKey)]))
            .get();
    final results = <LibraryRootScanResult>[];
    for (final root in roots) {
      var finalStatus = domain.ScanStatus.completed;
      String? message;
      final subscription = progress
          .where((event) => event.rootId == root.publicId)
          .listen((event) {
            finalStatus = event.status;
            message = event.message;
          });
      try {
        await scanAndWait(root.publicId);
      } finally {
        await subscription.cancel();
      }
      results.add(
        LibraryRootScanResult(
          rootId: root.publicId,
          status: finalStatus,
          message: message,
        ),
      );
      if (finalStatus == domain.ScanStatus.cancelled) {
        return ScanAllResult(results: results, cancelled: true);
      }
    }
    return ScanAllResult(results: results, cancelled: false);
  }

  Future<_UpsertResult> _upsertFile(
    LibraryRoot root,
    int generation,
    EnumeratedAudioFile file, {
    required bool allowPlatformIdentityMatch,
  }) async {
    var existing =
        await (_database.select(_database.mediaFiles)..where(
              (row) =>
                  row.rootId.equals(root.rowId) &
                  row.locatorKey.equals(file.locatorKey),
            ))
            .getSingleOrNull();
    if (existing == null &&
        allowPlatformIdentityMatch &&
        file.platformFileId != null) {
      final sameIdentity = await (_database.select(
        _database.mediaFiles,
      )..where((row) => row.platformFileId.equals(file.platformFileId!))).get();
      if (sameIdentity.length == 1) {
        existing = sameIdentity.single;
      }
    }
    if (existing == null && file.quickFingerprint != null) {
      final candidates =
          await (_database.select(_database.mediaFiles)..where(
                (row) =>
                    row.rootId.equals(root.rowId) &
                    row.quickFingerprint.equals(file.quickFingerprint!) &
                    row.lastSeenGeneration.isSmallerThanValue(generation),
              ))
              .get();
      if (candidates.length == 1) {
        existing = candidates.single;
      }
    }
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
              platformFileId: Value(file.platformFileId),
              quickFingerprint: Value(file.quickFingerprint),
              availabilityState: 'available',
              metadataState: 'pending',
              lastSeenGeneration: generation,
              lastSeenAt: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
      final metadataResult = await _metadataReader.read(file);
      final metadata = metadataResult.metadata;
      final trackPublicId = _uuid.v7();
      final trackId = await _database
          .into(_database.tracks)
          .insert(
            TracksCompanion.insert(
              publicId: trackPublicId,
              mediaFileId: mediaFileId,
              title: metadata.title,
              sortTitle: metadata.sortTitle,
              displayArtist: Value(metadata.artist),
              displayAlbum: Value(metadata.album),
              durationMs: Value(metadata.duration?.inMilliseconds),
              bitrateBps: Value(metadata.bitrateBps),
              sampleRateHz: Value(metadata.sampleRateHz),
              trackNumber: Value(metadata.trackNumber),
              trackTotal: Value(metadata.trackTotal),
              discNumber: Value(metadata.discNumber),
              discTotal: Value(metadata.discTotal),
              releaseYear: Value(metadata.releaseYear),
              searchText: metadata.searchText,
              metadataSource: Value(metadata.source),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await _syncFts(trackId, trackPublicId, metadata, file);
      await _persistRelations(trackId, metadata, now);
      await (_database.update(
        _database.mediaFiles,
      )..where((row) => row.rowId.equals(mediaFileId))).write(
        MediaFilesCompanion(
          metadataState: Value(metadataResult.isSuccess ? 'ready' : 'failed'),
        ),
      );
      return const _UpsertResult(inserted: 1);
    }
    final persistedFile = existing;
    final changed =
        persistedFile.sizeBytes != file.stat.size ||
        persistedFile.modifiedAtMicros !=
            file.stat.modified.toUtc().microsecondsSinceEpoch;
    await (_database.update(
      _database.mediaFiles,
    )..where((row) => row.rowId.equals(persistedFile.rowId))).write(
      MediaFilesCompanion(
        locator: Value(file.locator),
        relativePath: Value(file.relativePath),
        fileName: Value(file.fileName),
        extension: Value(file.extension),
        sizeBytes: Value(file.stat.size),
        modifiedAtMicros: Value(
          file.stat.modified.toUtc().microsecondsSinceEpoch,
        ),
        platformFileId: Value(file.platformFileId),
        quickFingerprint: Value(file.quickFingerprint),
        availabilityState: const Value('available'),
        lastSeenGeneration: Value(generation),
        lastSeenAt: Value(now),
        missingSince: const Value(null),
        updatedAt: Value(now),
      ),
    );
    if (changed) {
      final metadataResult = await _metadataReader.read(file);
      final metadata = metadataResult.metadata;
      final track =
          await (_database.select(_database.tracks)..where(
                (track) => track.mediaFileId.equals(persistedFile.rowId),
              ))
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
        await (_database.update(
          _database.mediaFiles,
        )..where((row) => row.rowId.equals(persistedFile.rowId))).write(
          MediaFilesCompanion(
            metadataState: Value(metadataResult.isSuccess ? 'ready' : 'failed'),
          ),
        );
        await _syncFts(track.rowId, track.publicId, metadata, file);
        await _persistRelations(track.rowId, metadata, now);
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

  Future<void> _persistRelations(
    int trackId,
    BasicTrackMetadata metadata,
    DateTime now,
  ) async {
    await (_database.delete(
      _database.trackArtists,
    )..where((row) => row.trackId.equals(trackId))).go();
    await (_database.delete(
      _database.trackGenres,
    )..where((row) => row.trackId.equals(trackId))).go();
    final artists = metadata.artists.isNotEmpty
        ? metadata.artists
        : [if (metadata.artist != null) metadata.artist!];
    int? albumArtistId;
    for (var position = 0; position < artists.length; position++) {
      final artistId = await _ensureArtist(artists[position], now);
      albumArtistId ??= artistId;
      await _database
          .into(_database.trackArtists)
          .insert(
            TrackArtistsCompanion.insert(
              trackId: trackId,
              artistId: artistId,
              role: position == 0 ? 'primary' : 'performer',
              position: position,
            ),
          );
    }
    if (metadata.albumArtist case final albumArtist?
        when albumArtist.trim().isNotEmpty) {
      albumArtistId = await _ensureArtist(albumArtist, now);
    }
    int? albumId;
    if (metadata.album case final album? when album.trim().isNotEmpty) {
      final identity = '${albumArtistId ?? 0}|${album.trim().toLowerCase()}';
      final existing = await (_database.select(
        _database.albums,
      )..where((row) => row.identityKey.equals(identity))).getSingleOrNull();
      if (existing != null) {
        albumId = existing.rowId;
      } else {
        albumId = await _database
            .into(_database.albums)
            .insert(
              AlbumsCompanion.insert(
                publicId: _uuid.v7(),
                title: album.trim(),
                sortTitle: album.trim().toLowerCase(),
                identityKey: identity,
                albumArtistId: Value(albumArtistId),
                releaseYear: Value(metadata.releaseYear),
                createdAt: now,
                updatedAt: now,
              ),
            );
      }
    }
    await (_database.update(_database.tracks)
          ..where((row) => row.rowId.equals(trackId)))
        .write(TracksCompanion(albumId: Value(albumId), updatedAt: Value(now)));
    for (var position = 0; position < metadata.genres.length; position++) {
      final name = metadata.genres[position].trim();
      if (name.isEmpty) continue;
      final identity = name.toLowerCase();
      final existing = await (_database.select(
        _database.genres,
      )..where((row) => row.identityKey.equals(identity))).getSingleOrNull();
      final genreId =
          existing?.rowId ??
          await _database
              .into(_database.genres)
              .insert(
                GenresCompanion.insert(
                  publicId: _uuid.v7(),
                  name: name,
                  identityKey: identity,
                  createdAt: now,
                  updatedAt: now,
                ),
              );
      await _database
          .into(_database.trackGenres)
          .insert(
            TrackGenresCompanion.insert(
              trackId: trackId,
              genreId: genreId,
              position: position,
            ),
          );
    }
  }

  Future<int> _ensureArtist(String name, DateTime now) async {
    final trimmed = name.trim();
    final identity = trimmed.toLowerCase();
    final existing = await (_database.select(
      _database.artists,
    )..where((row) => row.identityKey.equals(identity))).getSingleOrNull();
    return existing?.rowId ??
        _database
            .into(_database.artists)
            .insert(
              ArtistsCompanion.insert(
                publicId: _uuid.v7(),
                name: trimmed,
                sortName: identity,
                identityKey: identity,
                createdAt: now,
                updatedAt: now,
              ),
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
  }) {
    final progress = LibraryScanProgress(
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
    );
    _latestProgress[rootId] = progress;
    _progress.add(progress);
  }

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    for (final token in _active.values) {
      token.cancel();
    }
    await Future.wait(_runs.values.toList(growable: false));
    await _progress.close();
  }
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
