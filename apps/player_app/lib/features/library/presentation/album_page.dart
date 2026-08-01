import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/library_providers.dart';

class AlbumPage extends ConsumerWidget {
  const AlbumPage({super.key, required this.onPlayAll});
  final Future<void> Function(List<LibraryTrack> tracks) onPlayAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums =
        ref.watch(libraryAlbumsProvider).value ?? const <LibraryAlbum>[];
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return ListTile(
            leading: const Icon(Icons.album),
            title: Text(album.title),
            subtitle: Text(album.artist ?? 'Unknown artist'),
            onTap: () async {
              final tracks = await ref
                  .read(libraryFacadeProvider)
                  .query
                  .tracksForAlbum(album.id);
              if (!context.mounted) return;
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => _AlbumTracksPage(
                    title: album.title,
                    tracks: tracks,
                    onPlayAll: onPlayAll,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _AlbumTracksPage extends StatelessWidget {
  const _AlbumTracksPage({
    required this.title,
    required this.tracks,
    required this.onPlayAll,
  });
  final String title;
  final List<LibraryTrack> tracks;
  final Future<void> Function(List<LibraryTrack>) onPlayAll;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: tracks.isEmpty ? null : () => onPlayAll(tracks),
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (_, index) => ListTile(
        leading: Text('${index + 1}'),
        title: Text(tracks[index].title),
      ),
    ),
  );
}
