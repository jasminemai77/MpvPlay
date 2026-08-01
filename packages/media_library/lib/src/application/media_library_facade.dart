import 'dart:io';

import 'package:uuid/uuid.dart';

import '../domain/library_models.dart';
import '../infrastructure/database/dao/library_root_dao.dart';
import '../infrastructure/database/dao/library_track_dao.dart';
import '../infrastructure/database/dao/library_collection_dao.dart';
import '../infrastructure/database/dao/user_collections_dao.dart';
import '../infrastructure/database/media_library_database.dart'
    hide LibraryRoot, UserPlaylist;
import '../infrastructure/database/database_connection.dart';
import '../infrastructure/filesystem/path_normalizer.dart';
import 'library_scan_coordinator.dart';
import 'library_query_service.dart';

/// Application-facing media-library boundary. It owns no playback dependency.
final class MediaLibraryFacade {
  MediaLibraryFacade(this._database)
    : _roots = LibraryRootDao(_database),
      _userCollections = UserCollectionsDao(
        _database,
        LibraryTrackDao(_database),
      ),
      query = LibraryQueryService(
        LibraryRootDao(_database),
        LibraryTrackDao(_database),
        LibraryCollectionDao(_database),
        UserCollectionsDao(_database, LibraryTrackDao(_database)),
      );

  final MediaLibraryDatabase _database;
  final LibraryRootDao _roots;
  final UserCollectionsDao _userCollections;
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
  Stream<List<LibraryTrack>> watchFavoriteTracks() =>
      query.watchFavoriteTracks();
  Stream<bool> watchIsFavorite(String trackId) =>
      query.watchIsFavorite(trackId);
  Future<void> setFavorite(String trackId, bool favorite) =>
      _userCollections.setFavorite(trackId, favorite);
  Stream<List<UserPlaylist>> watchPlaylists() => query.watchPlaylists();
  Stream<UserPlaylistDetail?> watchPlaylist(String playlistId) =>
      query.watchPlaylist(playlistId);
  Future<UserPlaylist> createPlaylist({
    required String name,
    String? description,
  }) => _userCollections.createPlaylist(name: name, description: description);
  Future<void> renamePlaylist(String playlistId, String name) =>
      _userCollections.renamePlaylist(playlistId, name);
  Future<void> deletePlaylist(String playlistId) =>
      _userCollections.deletePlaylist(playlistId);
  Future<void> addTrackToPlaylist(String playlistId, String trackId) =>
      _userCollections.addTrackToPlaylist(playlistId, trackId);
  Future<void> removeTrackFromPlaylist(String playlistId, String trackId) =>
      _userCollections.removeTrackFromPlaylist(playlistId, trackId);
  Future<void> reorderPlaylistTracks(
    String playlistId,
    List<String> orderedTrackIds,
  ) => _userCollections.reorderPlaylistTracks(playlistId, orderedTrackIds);
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
