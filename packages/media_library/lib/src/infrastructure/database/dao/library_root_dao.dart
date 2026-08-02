import 'package:drift/drift.dart';

import '../../../domain/library_models.dart' as domain;
import '../media_library_database.dart';

final class LibraryRootDao {
  LibraryRootDao(this._database);
  final MediaLibraryDatabase _database;

  Future<domain.LibraryRoot> create({
    required String publicId,
    required String locator,
    required String locatorKey,
    required String displayName,
    bool recursive = true,
    bool enabled = true,
  }) async {
    final now = DateTime.now().toUtc();
    await _database
        .into(_database.libraryRoots)
        .insert(
          LibraryRootsCompanion.insert(
            publicId: publicId,
            sourceType: 'windowsDirectory',
            locator: locator,
            locatorKey: locatorKey,
            displayName: displayName,
            recursive: Value(recursive),
            enabled: Value(enabled),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return domain.LibraryRoot(
      id: publicId,
      sourceType: domain.LibrarySourceType.windowsDirectory,
      locator: locator,
      displayName: displayName,
      recursive: recursive,
      enabled: enabled,
    );
  }

  Future<List<domain.LibraryRoot>> list() async {
    final rows = await (_database.select(
      _database.libraryRoots,
    )..orderBy([(root) => OrderingTerm.asc(root.displayName)])).get();
    return rows.map(_toDomain).toList(growable: false);
  }

  Stream<List<domain.LibraryRoot>> watchAll() =>
      (_database.select(_database.libraryRoots)
            ..orderBy([(root) => OrderingTerm.asc(root.displayName)]))
          .watch()
          .map((rows) => rows.map(_toDomain).toList(growable: false));

  /// The latest persisted result complements the coordinator's transient state.
  Future<Map<String, domain.LibraryRootScanSummary>>
  latestScanSummaries() async {
    final query = _database.select(_database.scanRuns).join([
      innerJoin(
        _database.libraryRoots,
        _database.libraryRoots.rowId.equalsExp(_database.scanRuns.rootId),
      ),
    ])..orderBy([OrderingTerm.desc(_database.scanRuns.startedAt)]);
    final rows = await query.get();
    final summaries = <String, domain.LibraryRootScanSummary>{};
    for (final row in rows) {
      final root = row.readTable(_database.libraryRoots);
      if (summaries.containsKey(root.publicId)) continue;
      final run = row.readTable(_database.scanRuns);
      summaries[root.publicId] = domain.LibraryRootScanSummary(
        status: run.status,
        completedAt: run.finishedAt,
        message: run.failureMessage,
        discoveredCount: run.discoveredCount,
        missingCount: run.missingCount,
      );
    }
    return summaries;
  }

  Future<void> deleteByPublicId(String publicId) {
    return (_database.delete(
      _database.libraryRoots,
    )..where((root) => root.publicId.equals(publicId))).go();
  }

  Future<void> setEnabled(String publicId, bool enabled) =>
      _database.transaction(() async {
        final root = await (_database.select(
          _database.libraryRoots,
        )..where((row) => row.publicId.equals(publicId))).getSingleOrNull();
        if (root == null) return;
        final now = DateTime.now().toUtc();
        await (_database.update(
          _database.libraryRoots,
        )..where((row) => row.rowId.equals(root.rowId))).write(
          LibraryRootsCompanion(enabled: Value(enabled), updatedAt: Value(now)),
        );
        if (!enabled) {
          await (_database.update(
            _database.mediaFiles,
          )..where((file) => file.rootId.equals(root.rowId))).write(
            MediaFilesCompanion(
              availabilityState: const Value('missing'),
              missingSince: Value(now),
              updatedAt: Value(now),
            ),
          );
        }
      });

  domain.LibraryRoot _toDomain(LibraryRoot row) => domain.LibraryRoot(
    id: row.publicId,
    sourceType: domain.LibrarySourceType.windowsDirectory,
    locator: row.locator,
    displayName: row.displayName,
    recursive: row.recursive,
    enabled: row.enabled,
    scanGeneration: row.scanGeneration,
  );
}
