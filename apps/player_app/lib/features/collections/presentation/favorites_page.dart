import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/collections_providers.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key, required this.onPlay});
  final Future<void> Function(List<LibraryTrack> tracks, LibraryTrack selected)
  onPlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks =
        ref.watch(favoriteTracksProvider).value ?? const <LibraryTrack>[];
    final missing = ref.watch(missingFavoriteCountProvider).value ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            tooltip: 'Play all',
            onPressed: tracks.isEmpty
                ? null
                : () => onPlay(tracks, tracks.first),
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: Column(
        children: [
          if (missing > 0)
            ListTile(
              leading: const Icon(Icons.warning_amber_outlined),
              title: Text(
                '$missing favorite ${missing == 1 ? 'track is' : 'tracks are'} currently missing',
              ),
            ),
          Expanded(
            child: tracks.isEmpty
                ? const Center(child: Text('No available favorite tracks yet'))
                : ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];
                      return ListTile(
                        leading: const Icon(Icons.favorite),
                        title: Text(track.title),
                        subtitle: Text(track.displayArtist ?? 'Local file'),
                        onTap: () => onPlay(tracks, track),
                        trailing: IconButton(
                          tooltip: 'Remove favorite',
                          icon: const Icon(Icons.favorite),
                          onPressed: () => ref
                              .read(collectionsControllerProvider)
                              .setFavorite(track.id, false),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
