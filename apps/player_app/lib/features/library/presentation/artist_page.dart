import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/library_providers.dart';

class ArtistPage extends ConsumerWidget {
  const ArtistPage({super.key, required this.onPlayAll});
  final Future<void> Function(List<LibraryTrack> tracks) onPlayAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artists =
        ref.watch(libraryArtistsProvider).value ?? const <LibraryArtist>[];
    return Scaffold(
      appBar: AppBar(title: const Text('Artists')),
      body: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(artist.name),
            onTap: () async {
              final tracks = await ref
                  .read(libraryFacadeProvider)
                  .query
                  .tracksForArtist(artist.id);
              if (!context.mounted) return;
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => _ArtistTracksPage(
                    title: artist.name,
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

class _ArtistTracksPage extends StatelessWidget {
  const _ArtistTracksPage({
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
      itemBuilder: (_, index) => ListTile(title: Text(tracks[index].title)),
    ),
  );
}
