import '../domain/library_models.dart';
import '../infrastructure/database/dao/library_root_dao.dart';
import '../infrastructure/database/dao/library_track_dao.dart';
import '../infrastructure/database/dao/library_collection_dao.dart';

/// The only read surface exported to UI and application composition.
final class LibraryQueryService {
  LibraryQueryService(this._roots, this._tracks, this._collections);
  final LibraryRootDao _roots;
  final LibraryTrackDao _tracks;
  final LibraryCollectionDao _collections;

  Future<List<LibraryRoot>> listRoots() => _roots.list();
  Stream<List<LibraryRoot>> watchRoots() => _roots.watchAll();
  Future<List<LibraryTrack>> listTracks({int limit = 200, int offset = 0}) =>
      _tracks.list(limit: limit, offset: offset);
  Stream<List<LibraryTrack>> watchTracks({int limit = 200}) =>
      _tracks.watchAll(limit: limit);
  Stream<List<LibraryAlbum>> watchAlbums() => _collections.watchAlbums();
  Stream<List<LibraryArtist>> watchArtists() => _collections.watchArtists();
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
