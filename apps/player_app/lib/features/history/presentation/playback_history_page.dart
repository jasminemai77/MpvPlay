import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/history_providers.dart';

class PlaybackHistoryPage extends ConsumerWidget {
  const PlaybackHistoryPage({super.key, required this.onPlay});
  final Future<void> Function(List<LibraryTrack> tracks, LibraryTrack selected)
  onPlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries =
        ref.watch(recentPlaybackHistoryProvider).value ??
        const <PlaybackHistoryEntry>[];
    final missing = ref.watch(missingHistoryTrackCountProvider).value ?? 0;
    final recent = <LibraryTrack>[];
    final seen = <String>{};
    for (final entry in entries) {
      if (entry.track.available && seen.add(entry.track.id)) {
        recent.add(entry.track);
      }
      if (recent.length == 100) break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            tooltip: 'Play recent',
            onPressed: recent.isEmpty
                ? null
                : () => onPlay(recent, recent.first),
            icon: const Icon(Icons.play_arrow),
          ),
          IconButton(
            tooltip: 'Clear history',
            onPressed: entries.isEmpty ? null : () => _clear(context, ref),
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          if (missing > 0)
            ListTile(
              leading: const Icon(Icons.warning_amber_outlined),
              title: Text('$missing history entries have unavailable files'),
            ),
          Expanded(
            child: entries.isEmpty
                ? const Center(child: Text('No playback history yet'))
                : ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final track = entry.track;
                      return ListTile(
                        enabled: track.available,
                        leading: Icon(
                          track.available
                              ? Icons.history
                              : Icons.portable_wifi_off_outlined,
                        ),
                        title: Text(track.title),
                        subtitle: Text(
                          track.available
                              ? '${track.displayArtist ?? 'Local file'} · ${_when(entry.startedAt)}'
                              : 'File unavailable · ${_when(entry.startedAt)}',
                        ),
                        trailing: Text('${entry.playCount} plays'),
                        onTap: track.available
                            ? () => onPlay([track], track)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _clear(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear history?'),
        content: const Text(
          'This deletes recent playback records and resets all play counts.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Clear history'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(playbackHistoryControllerProvider).clearHistory();
    } on PlaybackHistoryFailure catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.code.name)));
      }
    }
  }
}

String _when(DateTime value) =>
    '${value.toLocal().year}-${value.toLocal().month.toString().padLeft(2, '0')}-${value.toLocal().day.toString().padLeft(2, '0')} ${value.toLocal().hour.toString().padLeft(2, '0')}:${value.toLocal().minute.toString().padLeft(2, '0')}';
