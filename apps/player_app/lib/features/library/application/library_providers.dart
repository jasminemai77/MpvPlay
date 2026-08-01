import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

final libraryFacadeProvider = Provider<MediaLibraryFacade>(
  (_) => throw UnimplementedError(),
);
final libraryScanCoordinatorProvider = Provider<LibraryScanCoordinator>(
  (_) => throw UnimplementedError(),
);
final libraryRootsProvider = StreamProvider<List<LibraryRoot>>(
  (ref) => ref.watch(libraryFacadeProvider).query.watchRoots(),
);
final libraryTracksProvider = StreamProvider<List<LibraryTrack>>(
  (ref) => ref.watch(libraryFacadeProvider).query.watchTracks(),
);
final libraryAlbumsProvider = StreamProvider<List<LibraryAlbum>>(
  (ref) => ref.watch(libraryFacadeProvider).query.watchAlbums(),
);
final libraryArtistsProvider = StreamProvider<List<LibraryArtist>>(
  (ref) => ref.watch(libraryFacadeProvider).query.watchArtists(),
);
final libraryScanProgressProvider = StreamProvider<LibraryScanProgress>(
  (ref) => ref.watch(libraryScanCoordinatorProvider).progress,
);
final libraryControllerProvider = Provider<LibraryController>(
  (ref) => LibraryController(
    ref.watch(libraryFacadeProvider),
    ref.watch(libraryScanCoordinatorProvider),
  ),
);

final class LibraryController {
  LibraryController(this._library, this._scanner);
  final MediaLibraryFacade _library;
  final LibraryScanCoordinator _scanner;

  Future<LibraryRoot> addDirectory(String path) async {
    final root = await _library.addDirectoryRoot(
      locator: path,
      displayName: path.split(RegExp(r'[\\/]')).last,
    );
    _scanner.scan(root.id);
    return root;
  }

  ScanCancellationToken rescan(String rootId) => _scanner.scan(rootId);
  Future<void> removeRoot(String rootId) => _library.removeRoot(rootId);
}
