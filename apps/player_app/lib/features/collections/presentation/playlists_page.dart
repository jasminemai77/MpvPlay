import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/collections_providers.dart';
import 'playlist_detail_page.dart';

class PlaylistsPage extends ConsumerWidget {
  const PlaylistsPage({super.key, required this.onPlay});
  final Future<void> Function(List<LibraryTrack> tracks, LibraryTrack selected)
  onPlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlists =
        ref.watch(userPlaylistsProvider).value ?? const <UserPlaylist>[];
    return Scaffold(
      appBar: AppBar(title: const Text('Playlists')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _editPlaylist(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Create'),
      ),
      body: playlists.isEmpty
          ? const Center(
              child: Text('Create a playlist to organize your music'),
            )
          : ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return ListTile(
                  leading: const Icon(Icons.queue_music),
                  title: Text(playlist.name),
                  subtitle: Text('${playlist.trackCount} tracks'),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => PlaylistDetailPage(
                        playlistId: playlist.id,
                        onPlay: onPlay,
                      ),
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (action) async {
                      if (action == 'rename') {
                        await _editPlaylist(context, ref, playlist: playlist);
                      } else if (action == 'delete') {
                        final confirmed = await _confirm(
                          context,
                          'Delete ${playlist.name}?',
                        );
                        if (confirmed == true) {
                          await ref
                              .read(collectionsControllerProvider)
                              .deletePlaylist(playlist.id);
                        }
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'rename', child: Text('Rename')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<void> _editPlaylist(
    BuildContext context,
    WidgetRef ref, {
    UserPlaylist? playlist,
  }) async {
    final controller = TextEditingController(text: playlist?.name ?? '');
    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(playlist == null ? 'Create playlist' : 'Rename playlist'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (value == null) return;
    try {
      final actions = ref.read(collectionsControllerProvider);
      if (playlist == null) {
        await actions.createPlaylist(name: value);
      } else {
        await actions.renamePlaylist(playlist.id, value);
      }
    } on CollectionFailure catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.code.name)));
      }
    }
  }

  Future<bool?> _confirm(BuildContext context, String message) =>
      showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
}
