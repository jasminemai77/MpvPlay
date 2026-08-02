import '../domain/library_models.dart';
import '../infrastructure/database/dao/library_root_dao.dart';
import '../infrastructure/database/dao/library_track_dao.dart';
import '../infrastructure/database/dao/playback_history_dao.dart';
import '../infrastructure/database/dao/library_collection_dao.dart';
import '../infrastructure/database/dao/user_collections_dao.dart';

/// The only read surface exported to UI and application composition.
final class LibraryQueryService {
  LibraryQueryService(
    this._roots,
    this._tracks,
    this._collections,
    this._userCollections,
    this._history,
  );
  final LibraryRootDao _roots;
  final LibraryTrackDao _tracks;
  final LibraryCollectionDao _collections;
  final UserCollectionsDao _userCollections;
  final PlaybackHistoryDao _history;

  Future<List<LibraryRoot>> listRoots() => _roots.list();
  Stream<List<LibraryRoot>> watchRoots() => _roots.watchAll();
  Future<List<LibraryTrack>> listTracks({int limit = 200, int offset = 0}) =>
      _tracks.list(limit: limit, offset: offset);
  Stream<List<LibraryTrack>> watchTracks({int limit = 200}) =>
      _tracks.watchAll(limit: limit);
  Stream<List<LibraryAlbum>> watchAlbums() => _collections.watchAlbums();
  Stream<List<LibraryArtist>> watchArtists() => _collections.watchArtists();
  Stream<List<LibraryTrack>> watchFavoriteTracks() =>
      _userCollections.watchFavoriteTracks();
  Stream<int> watchMissingFavoriteCount() =>
      _userCollections.watchMissingFavoriteCount();
  Stream<bool> watchIsFavorite(String trackId) =>
      _userCollections.watchIsFavorite(trackId);
  Stream<List<UserPlaylist>> watchPlaylists() =>
      _userCollections.watchPlaylists();
  Stream<UserPlaylistDetail?> watchPlaylist(String playlistId) =>
      _userCollections.watchPlaylist(playlistId);
  Stream<List<PlaybackHistoryEntry>> watchRecentPlaybackHistory({
    int limit = 200,
  }) => _history.watchRecent(limit: limit);
  Stream<TrackPlaybackStats?> watchTrackPlaybackStats(String trackId) =>
      _history.watchStats(trackId);
  Stream<int> watchMissingHistoryTrackCount() =>
      _history.watchMissingTrackCount();
  Future<List<LibraryTrack>> tracksForAlbum(String albumId) =>
      _tracks.forAlbum(albumId);
  Future<List<LibraryTrack>> tracksForArtist(String artistId) =>
      _tracks.forArtist(artistId);
  Future<List<LibraryTrack>> searchTracks(String query, {int limit = 100}) =>
      _searchTracks(query.trim(), limit);

  Future<List<LibraryTrack>> _searchTracks(String query, int limit) async {
    if (query.runes.length < 3) return _tracks.searchLike(query, limit: limit);
    final results = await _tracks.searchFts(query);
    return results.take(limit).toList(growable: false);
  }
}
