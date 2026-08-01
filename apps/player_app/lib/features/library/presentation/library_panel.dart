import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/library_providers.dart';
import 'album_page.dart';
import 'artist_page.dart';
import '../../collections/application/collections_providers.dart';
import '../../collections/presentation/add_to_playlist_dialog.dart';
import '../../collections/presentation/favorites_page.dart';
import '../../collections/presentation/playlists_page.dart';

class LibraryPanel extends ConsumerStatefulWidget {
  const LibraryPanel({super.key, required this.onPlay});
  final Future<void> Function(List<LibraryTrack> tracks, LibraryTrack selected)
  onPlay;

  @override
  ConsumerState<LibraryPanel> createState() => _LibraryPanelState();
}

class _LibraryPanelState extends ConsumerState<LibraryPanel> {
  final _search = TextEditingController();
  final _tokens = <String, ScanCancellationToken>{};
  List<LibraryTrack>? _results;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _addRoot() async {
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Add music folder',
    );
    if (path == null || !mounted) {
      return;
    }
    try {
      await ref.read(libraryControllerProvider).addDirectory(path);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _searchTracks(String value) async {
    final results = await ref
        .read(libraryFacadeProvider)
        .query
        .searchTracks(value);
    if (mounted) {
      setState(() => _results = results);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roots =
        ref.watch(libraryRootsProvider).value ?? const <LibraryRoot>[];
    final allTracks =
        ref.watch(libraryTracksProvider).value ?? const <LibraryTrack>[];
    final tracks = _results ?? allTracks;
    final progress = ref.watch(libraryScanProgressProvider).value;
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.library_music),
            title: const Text('Local library'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton<_LibraryDestination>(
                  tooltip: 'Collections',
                  icon: const Icon(Icons.library_books_outlined),
                  onSelected: (destination) {
                    final page = switch (destination) {
                      _LibraryDestination.favorites => FavoritesPage(
                        onPlay: widget.onPlay,
                      ),
                      _LibraryDestination.playlists => PlaylistsPage(
                        onPlay: widget.onPlay,
                      ),
                      _LibraryDestination.albums => AlbumPage(
                        onPlayAll: _playAll,
                      ),
                      _LibraryDestination.artists => ArtistPage(
                        onPlayAll: _playAll,
                      ),
                    };
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute<void>(builder: (_) => page));
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: _LibraryDestination.favorites,
                      child: Text('Favorites'),
                    ),
                    PopupMenuItem(
                      value: _LibraryDestination.playlists,
                      child: Text('Playlists'),
                    ),
                    PopupMenuItem(
                      value: _LibraryDestination.albums,
                      child: Text('Albums'),
                    ),
                    PopupMenuItem(
                      value: _LibraryDestination.artists,
                      child: Text('Artists'),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.create_new_folder_outlined),
                  tooltip: 'Add folder',
                  onPressed: _addRoot,
                ),
              ],
            ),
          ),
          if (progress != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${progress.status.name}: ${progress.discoveredCount} files',
                    ),
                  ),
                  if (_tokens[progress.rootId] case final token?)
                    TextButton(
                      onPressed: token.cancel,
                      child: const Text('Cancel'),
                    ),
                ],
              ),
            ),
          if (roots.isNotEmpty)
            SizedBox(
              height: 52,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: roots.length,
                itemBuilder: (context, index) {
                  final root = roots[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InputChip(
                      label: Text(root.displayName),
                      onPressed: () => setState(
                        () => _tokens[root.id] = ref
                            .read(libraryControllerProvider)
                            .rescan(root.id),
                      ),
                      onDeleted: () => ref
                          .read(libraryControllerProvider)
                          .removeRoot(root.id),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search library',
              ),
              onChanged: _searchTracks,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: tracks.isEmpty
                ? const Center(
                    child: Text('Add a music folder to build your library'),
                  )
                : ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];
                      final favorite =
                          ref.watch(isFavoriteProvider(track.id)).value ??
                          false;
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.music_note),
                        title: Text(track.title),
                        subtitle: Text(
                          track.displayArtist ??
                              track.displayAlbum ??
                              'Local file',
                        ),
                        enabled: track.available,
                        onTap: track.available
                            ? () => widget.onPlay(tracks, track)
                            : null,
                        trailing: Wrap(
                          children: [
                            IconButton(
                              tooltip: favorite
                                  ? 'Remove favorite'
                                  : 'Add favorite',
                              onPressed: () => ref
                                  .read(collectionsControllerProvider)
                                  .setFavorite(track.id, !favorite),
                              icon: Icon(
                                favorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                              ),
                            ),
                            IconButton(
                              tooltip: 'Add to playlist',
                              onPressed: () => showAddToPlaylistDialog(
                                context,
                                ref,
                                track.id,
                              ),
                              icon: const Icon(Icons.playlist_add),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _playAll(List<LibraryTrack> tracks) {
    if (tracks.isEmpty) return Future.value();
    return widget.onPlay(tracks, tracks.first);
  }
}

enum _LibraryDestination { favorites, playlists, albums, artists }
