import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../../library/application/library_providers.dart';

final favoriteTracksProvider = StreamProvider<List<LibraryTrack>>(
  (ref) => ref.watch(libraryFacadeProvider).watchFavoriteTracks(),
);
final missingFavoriteCountProvider = StreamProvider<int>(
  (ref) => ref.watch(libraryFacadeProvider).query.watchMissingFavoriteCount(),
);
final isFavoriteProvider = StreamProvider.family<bool, String>(
  (ref, trackId) => ref.watch(libraryFacadeProvider).watchIsFavorite(trackId),
);
final userPlaylistsProvider = StreamProvider<List<UserPlaylist>>(
  (ref) => ref.watch(libraryFacadeProvider).watchPlaylists(),
);
final userPlaylistProvider = StreamProvider.family<UserPlaylistDetail?, String>(
  (ref, playlistId) =>
      ref.watch(libraryFacadeProvider).watchPlaylist(playlistId),
);
final collectionsControllerProvider = Provider<CollectionsController>(
  (ref) => CollectionsController(ref.watch(libraryFacadeProvider)),
);

final class CollectionsController {
  CollectionsController(this._library);
  final MediaLibraryFacade _library;

  Future<void> setFavorite(String trackId, bool favorite) =>
      _library.setFavorite(trackId, favorite);
  Future<UserPlaylist> createPlaylist({
    required String name,
    String? description,
  }) => _library.createPlaylist(name: name, description: description);
  Future<void> renamePlaylist(String playlistId, String name) =>
      _library.renamePlaylist(playlistId, name);
  Future<void> deletePlaylist(String playlistId) =>
      _library.deletePlaylist(playlistId);
  Future<void> addTrack(String playlistId, String trackId) =>
      _library.addTrackToPlaylist(playlistId, trackId);
  Future<void> removeTrack(String playlistId, String trackId) =>
      _library.removeTrackFromPlaylist(playlistId, trackId);
  Future<void> reorder(String playlistId, List<String> trackIds) =>
      _library.reorderPlaylistTracks(playlistId, trackIds);
}
