import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_settings/app_settings.dart';
import 'package:media_library/media_library.dart';
import '../../settings/application/settings_providers.dart';

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
    ref.watch(appSettingsRepositoryProvider),
  ),
);

final class LibraryController {
  LibraryController(this._library, this._scanner, this._settings);
  final MediaLibraryFacade _library;
  final LibraryScanCoordinator _scanner;
  final AppSettingsRepository _settings;

  Future<LibraryRoot> addDirectory(String path) async {
    final root = await _library.addDirectoryRoot(
      locator: path,
      displayName: path.split(RegExp(r'[\\/]')).last,
    );
    if (_settings.current.scanNewRootsImmediately) _scanner.scan(root.id);
    return root;
  }

  ScanCancellationToken rescan(String rootId) => _scanner.scan(rootId);

  /// Root disablement is serialized with the single scan coordinator.
  Future<void> removeRoot(String rootId) async {
    await _scanner.cancelActiveScan();
    await _library.removeRoot(rootId);
  }
}
