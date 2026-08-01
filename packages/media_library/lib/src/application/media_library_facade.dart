import 'dart:io';

import 'package:uuid/uuid.dart';

import '../domain/library_models.dart';
import '../infrastructure/database/dao/library_root_dao.dart';
import '../infrastructure/database/dao/library_track_dao.dart';
import '../infrastructure/database/dao/library_collection_dao.dart';
import '../infrastructure/database/media_library_database.dart'
    hide LibraryRoot;
import '../infrastructure/database/database_connection.dart';
import '../infrastructure/filesystem/path_normalizer.dart';
import 'library_scan_coordinator.dart';
import 'library_query_service.dart';

/// Application-facing media-library boundary. It owns no playback dependency.
final class MediaLibraryFacade {
  MediaLibraryFacade(this._database)
    : _roots = LibraryRootDao(_database),
      query = LibraryQueryService(
        LibraryRootDao(_database),
        LibraryTrackDao(_database),
        LibraryCollectionDao(_database),
      );

  final MediaLibraryDatabase _database;
  final LibraryRootDao _roots;
  final LibraryQueryService query;
  static const _uuid = Uuid();
  static const _normalizer = WindowsPathNormalizer();

  factory MediaLibraryFacade.open(File databaseFile) => MediaLibraryFacade(
    MediaLibraryDatabase(openMediaLibraryDatabase(databaseFile)),
  );

  Future<LibraryRoot> addDirectoryRoot({
    required String locator,
    required String displayName,
    bool recursive = true,
  }) async {
    final normalized = _normalizer.normalizeLocator(locator);
    final existing = await _roots.list();
    if (existing.any(
      (root) => _normalizer.overlaps(root.locator, normalized),
    )) {
      throw LibraryRootOverlapException(normalized);
    }
    return _roots.create(
      publicId: _uuid.v7(),
      locator: normalized,
      locatorKey: _normalizer.locatorKey(normalized),
      displayName: displayName,
      recursive: recursive,
    );
  }

  Future<void> removeRoot(String publicId) => _roots.deleteByPublicId(publicId);
  LibraryScanCoordinator createScanCoordinator() =>
      LibraryScanCoordinator(_database);
  Future<void> close() => _database.close();
}

final class LibraryRootOverlapException implements Exception {
  const LibraryRootOverlapException(this.locator);
  final String locator;
  @override
  String toString() => 'Library root overlaps an existing root: $locator';
}
