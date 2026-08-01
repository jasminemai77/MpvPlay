import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/collections_providers.dart';

Future<void> showAddToPlaylistDialog(
  BuildContext context,
  WidgetRef ref,
  String trackId,
) => showDialog<void>(
  context: context,
  builder: (dialogContext) {
    final playlists = ref.watch(userPlaylistsProvider).value ?? const [];
    return AlertDialog(
      title: const Text('Add to playlist'),
      content: playlists.isEmpty
          ? const Text('Create a playlist first.')
          : SizedBox(
              width: 360,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: playlists.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(playlists[index].name),
                  onTap: () async {
                    try {
                      await ref
                          .read(collectionsControllerProvider)
                          .addTrack(playlists[index].id, trackId);
                      if (dialogContext.mounted) Navigator.pop(dialogContext);
                    } catch (error) {
                      if (dialogContext.mounted) {
                        ScaffoldMessenger.of(
                          dialogContext,
                        ).showSnackBar(SnackBar(content: Text('$error')));
                      }
                    }
                  },
                ),
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Close'),
        ),
      ],
    );
  },
);
