import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/collections_providers.dart';

class PlaylistDetailPage extends ConsumerWidget {
  const PlaylistDetailPage({
    super.key,
    required this.playlistId,
    required this.onPlay,
  });
  final String playlistId;
  final Future<void> Function(List<LibraryTrack> tracks, LibraryTrack selected)
  onPlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(userPlaylistProvider(playlistId)).value;
    if (detail == null) {
      return const Scaffold(body: Center(child: Text('Playlist not found')));
    }
    final playable = detail.tracks
        .where((track) => track.available)
        .toList(growable: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(detail.playlist.name),
        actions: [
          IconButton(
            tooltip: 'Play all',
            onPressed: playable.isEmpty
                ? null
                : () => onPlay(playable, playable.first),
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: detail.tracks.isEmpty
          ? const Center(child: Text('This playlist is empty'))
          : ListView.builder(
              itemCount: detail.tracks.length,
              itemBuilder: (context, index) {
                final track = detail.tracks[index];
                return ListTile(
                  enabled: track.available,
                  leading: Text('${index + 1}'),
                  title: Text(track.title),
                  subtitle: Text(
                    track.available
                        ? (track.displayArtist ?? 'Local file')
                        : 'Missing track',
                  ),
                  onTap: track.available ? () => onPlay(playable, track) : null,
                  trailing: Wrap(
                    spacing: 0,
                    children: [
                      IconButton(
                        tooltip: 'Move up',
                        onPressed: index == 0
                            ? null
                            : () => _move(ref, detail, index, index - 1),
                        icon: const Icon(Icons.arrow_upward),
                      ),
                      IconButton(
                        tooltip: 'Move down',
                        onPressed: index == detail.tracks.length - 1
                            ? null
                            : () => _move(ref, detail, index, index + 1),
                        icon: const Icon(Icons.arrow_downward),
                      ),
                      IconButton(
                        tooltip: 'Remove track',
                        onPressed: () => ref
                            .read(collectionsControllerProvider)
                            .removeTrack(playlistId, track.id),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<void> _move(
    WidgetRef ref,
    UserPlaylistDetail detail,
    int from,
    int to,
  ) {
    final ids = detail.tracks.map((track) => track.id).toList(growable: false);
    final mutable = ids.toList();
    final moved = mutable.removeAt(from);
    mutable.insert(to, moved);
    return ref.read(collectionsControllerProvider).reorder(playlistId, mutable);
  }
}
