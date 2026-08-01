import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:player_core/player_core.dart';

import '../application/playback_providers.dart';

class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({super.key});
  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  double? _dragging;
  Future<void> _send(PlaybackCommand command) async {
    try {
      await ref.read(clientProvider).send(command);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _pick(PlaybackSnapshot snapshot) async {
    final selected = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: const [
        'mp3',
        'flac',
        'wav',
        'm4a',
        'aac',
        'ogg',
        'opus',
      ],
    );
    final items = (selected?.paths.whereType<String>() ?? const <String>[]).map(
      (path) {
        final uri = Uri.file(path);
        return PlayableItem(
          id: uri.toString(),
          title: path.split(RegExp(r'[\\/]')).last,
          source: MediaSource(
            id: uri.toString(),
            uri: uri,
            kind: MediaKind.audio,
          ),
        );
      },
    ).toList();
    if (items.isEmpty) return;
    final meta = commandMetadata(snapshot, 'load');
    await _send(
      LoadQueue(
        commandId: meta.commandId,
        sessionId: meta.sessionId,
        issuedAt: meta.issuedAt,
        items: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final snapshot =
        (ref.watch(snapshotProvider).value ??
        ref.watch(initialSnapshotProvider))!;
    final playing = snapshot.status == PlaybackStatus.playing;
    final maximum = snapshot.duration.inMilliseconds
        .toDouble()
        .clamp(1, double.infinity)
        .toDouble();
    final position = (_dragging ?? snapshot.position.inMilliseconds.toDouble())
        .clamp(0, maximum)
        .toDouble();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MpvPlay'),
        actions: [
          Center(child: Text(snapshot.status.name)),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.album_rounded, size: 128),
                          const SizedBox(height: 20),
                          Text(
                            snapshot.currentItem?.title ?? 'No music selected',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Slider(
                    value: position,
                    max: maximum,
                    onChanged: snapshot.currentItem == null
                        ? null
                        : (value) => setState(() => _dragging = value),
                    onChangeEnd: (value) {
                      setState(() => _dragging = null);
                      final meta = commandMetadata(snapshot, 'seek');
                      _send(
                        Seek(
                          commandId: meta.commandId,
                          sessionId: meta.sessionId,
                          issuedAt: meta.issuedAt,
                          position: Duration(milliseconds: value.round()),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_format(Duration(milliseconds: position.round()))),
                      Text(_format(snapshot.duration)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(
                        snapshot,
                        Icons.skip_previous,
                        'Previous',
                        (m) => SkipPrevious(
                          commandId: m.commandId,
                          sessionId: m.sessionId,
                          issuedAt: m.issuedAt,
                        ),
                      ),
                      IconButton(
                        iconSize: 46,
                        tooltip: playing ? 'Pause' : 'Play',
                        onPressed: snapshot.currentItem == null
                            ? null
                            : () {
                                final m = commandMetadata(
                                  snapshot,
                                  playing ? 'pause' : 'play',
                                );
                                _send(
                                  playing
                                      ? Pause(
                                          commandId: m.commandId,
                                          sessionId: m.sessionId,
                                          issuedAt: m.issuedAt,
                                        )
                                      : Play(
                                          commandId: m.commandId,
                                          sessionId: m.sessionId,
                                          issuedAt: m.issuedAt,
                                        ),
                                );
                              },
                        icon: Icon(
                          playing ? Icons.pause_circle : Icons.play_circle,
                        ),
                      ),
                      _button(
                        snapshot,
                        Icons.stop_circle_outlined,
                        'Stop',
                        (m) => Stop(
                          commandId: m.commandId,
                          sessionId: m.sessionId,
                          issuedAt: m.issuedAt,
                        ),
                      ),
                      _button(
                        snapshot,
                        Icons.skip_next,
                        'Next',
                        (m) => SkipNext(
                          commandId: m.commandId,
                          sessionId: m.sessionId,
                          issuedAt: m.issuedAt,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          final m = commandMetadata(snapshot, 'mute');
                          _send(
                            SetMuted(
                              commandId: m.commandId,
                              sessionId: m.sessionId,
                              issuedAt: m.issuedAt,
                              muted: !snapshot.muted,
                            ),
                          );
                        },
                        icon: Icon(
                          snapshot.muted ? Icons.volume_off : Icons.volume_up,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: snapshot.volume,
                          onChanged: (value) {
                            final m = commandMetadata(snapshot, 'volume');
                            _send(
                              SetVolume(
                                commandId: m.commandId,
                                sessionId: m.sessionId,
                                issuedAt: m.issuedAt,
                                value: value,
                              ),
                            );
                          },
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () => _pick(snapshot),
                        icon: const Icon(Icons.audio_file),
                        label: const Text('Choose music'),
                      ),
                    ],
                  ),
                  if (snapshot.failure != null)
                    Card(
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(snapshot.failure!.message),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Card(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.queue_music),
                      title: Text('Playback queue'),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: snapshot.queueItems.isEmpty
                          ? const Center(child: Text('Queue is empty'))
                          : ListView.builder(
                              itemCount: snapshot.queueItems.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.queueItems[index];
                                return ListTile(
                                  selected: index == snapshot.currentIndex,
                                  title: Text(item.title),
                                  onTap: () {
                                    final m = commandMetadata(
                                      snapshot,
                                      'select',
                                    );
                                    _send(
                                      SelectQueueItem(
                                        commandId: m.commandId,
                                        sessionId: m.sessionId,
                                        issuedAt: m.issuedAt,
                                        index: index,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(
    PlaybackSnapshot snapshot,
    IconData icon,
    String tip,
    PlaybackCommand Function(
      ({String commandId, String sessionId, DateTime issuedAt}),
    )
    create,
  ) => IconButton(
    icon: Icon(icon),
    tooltip: tip,
    onPressed: () {
      final m = commandMetadata(snapshot, tip);
      _send(create(m));
    },
  );
}

String _format(Duration value) =>
    '${value.inMinutes.remainder(60).toString().padLeft(2, '0')}:${value.inSeconds.remainder(60).toString().padLeft(2, '0')}';
