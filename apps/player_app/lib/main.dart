import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playback_engine_mpv/playback_engine_mpv.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:platform_bridge/platform_bridge.dart';
import 'package:player_core/player_core.dart';

final clientProvider = Provider<PlaybackClient>(
  (_) => throw UnimplementedError(),
);
final initialProvider = Provider<PlaybackSnapshot>(
  (_) => throw UnimplementedError(),
);
final snapshotProvider = StreamProvider<PlaybackSnapshot>(
  (ref) => ref.watch(clientProvider).snapshots,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationSupportDirectory();
  final runtime = PlaybackRuntime(
    engine: MpvPlaybackEngine(),
    logSink: JsonLinePlaybackLogger(
      File('${directory.path}${Platform.pathSeparator}playback.log.jsonl'),
    ).call,
  );
  await runtime.initialize();
  final store = JsonSessionStore(
    File('${directory.path}${Platform.pathSeparator}session.json'),
  );
  final restored = await store.restore();
  if (restored != null && restored.items.isNotEmpty) {
    await runtime.send(
      LoadQueue(
        commandId: 'restore',
        sessionId: runtime.runtimeSessionId,
        issuedAt: DateTime.now(),
        items: restored.items,
        initialIndex: restored.currentIndex,
        startPosition: restored.position,
        autoPlay: false,
      ),
    );
    await runtime.send(
      SetVolume(
        commandId: 'restore-volume',
        sessionId: runtime.runtimeSessionId,
        issuedAt: DateTime.now(),
        value: restored.volume,
      ),
    );
    await runtime.send(
      SetMuted(
        commandId: 'restore-muted',
        sessionId: runtime.runtimeSessionId,
        issuedAt: DateTime.now(),
        muted: restored.muted,
      ),
    );
    runtime.reportSessionRestored(
      restoredItems: restored.items.length,
      skippedItems: restored.skippedItems,
    );
  }
  runtime.snapshots.listen(store.save);
  runApp(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(InProcessPlaybackClient(runtime)),
        initialProvider.overrideWithValue(runtime.currentSnapshot),
      ],
      child: const MpvPlayApp(),
    ),
  );
}

class MpvPlayApp extends StatelessWidget {
  const MpvPlayApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MpvPlay',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff6750a4),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    ),
    home: const PlayerPage(),
  );
}

class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({super.key});
  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  double? dragging;
  ({String commandId, String sessionId, DateTime issuedAt}) meta(
    PlaybackSnapshot s,
    String name,
  ) => (
    commandId: '$name-${DateTime.now().microsecondsSinceEpoch}',
    sessionId: s.sessionId,
    issuedAt: DateTime.now(),
  );
  Future<void> send(PlaybackCommand value) async {
    try {
      await ref.read(clientProvider).send(value);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  Future<void> pick(PlaybackSnapshot snapshot) async {
    final result = await FilePicker.platform.pickFiles(
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
    final paths =
        result?.paths.whereType<String>() ?? const Iterable<String>.empty();
    final items = paths.map((path) {
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
    }).toList();
    if (items.isEmpty) return;
    final m = meta(snapshot, 'load');
    await send(
      LoadQueue(
        commandId: m.commandId,
        sessionId: m.sessionId,
        issuedAt: m.issuedAt,
        items: items,
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PlaybackSnapshot snapshot =
        ref.watch(snapshotProvider).value ?? ref.watch(initialProvider)!;
    final playing = snapshot.status == PlaybackStatus.playing;
    final max = snapshot.duration.inMilliseconds
        .toDouble()
        .clamp(1, double.infinity)
        .toDouble();
    final position = (dragging ?? snapshot.position.inMilliseconds.toDouble())
        .clamp(0, max)
        .toDouble();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MpvPlay'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(child: Text(snapshot.status.name)),
          ),
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
                            snapshot.currentItem?.title ?? '尚未选择音乐',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Slider(
                    value: position,
                    max: max,
                    onChanged: snapshot.currentItem == null
                        ? null
                        : (v) => setState(() => dragging = v),
                    onChangeEnd: (v) {
                      setState(() => dragging = null);
                      final m = meta(snapshot, 'seek');
                      send(
                        Seek(
                          commandId: m.commandId,
                          sessionId: m.sessionId,
                          issuedAt: m.issuedAt,
                          position: Duration(milliseconds: v.round()),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(
                          Duration(milliseconds: position.round()),
                        ),
                      ),
                      Text(formatDuration(snapshot.duration)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      action(
                        snapshot,
                        Icons.skip_previous,
                        '上一首',
                        (m) => SkipPrevious(
                          commandId: m.commandId,
                          sessionId: m.sessionId,
                          issuedAt: m.issuedAt,
                        ),
                      ),
                      IconButton(
                        iconSize: 46,
                        tooltip: playing ? '暂停' : '播放',
                        onPressed: snapshot.currentItem == null
                            ? null
                            : () {
                                final m = meta(
                                  snapshot,
                                  playing ? 'pause' : 'play',
                                );
                                send(
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
                      action(
                        snapshot,
                        Icons.stop_circle_outlined,
                        '停止',
                        (m) => Stop(
                          commandId: m.commandId,
                          sessionId: m.sessionId,
                          issuedAt: m.issuedAt,
                        ),
                      ),
                      action(
                        snapshot,
                        Icons.skip_next,
                        '下一首',
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
                          final m = meta(snapshot, 'mute');
                          send(
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
                          onChanged: (v) {
                            final m = meta(snapshot, 'volume');
                            send(
                              SetVolume(
                                commandId: m.commandId,
                                sessionId: m.sessionId,
                                issuedAt: m.issuedAt,
                                value: v,
                              ),
                            );
                          },
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () => pick(snapshot),
                        icon: const Icon(Icons.audio_file),
                        label: const Text('选择音乐'),
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
                      title: Text('播放队列'),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: snapshot.queueItems.isEmpty
                          ? const Center(child: Text('队列为空'))
                          : ListView.builder(
                              itemCount: snapshot.queueItems.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.queueItems[index];
                                return ListTile(
                                  selected: index == snapshot.currentIndex,
                                  leading: Text('${index + 1}'),
                                  title: Text(
                                    item.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: index == snapshot.currentIndex
                                      ? const Icon(Icons.graphic_eq)
                                      : null,
                                  onTap: () {
                                    final m = meta(snapshot, 'select');
                                    send(
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

  Widget action(
    PlaybackSnapshot s,
    IconData icon,
    String tip,
    PlaybackCommand Function(
      ({String commandId, String sessionId, DateTime issuedAt}),
    )
    create,
  ) => IconButton(
    iconSize: 32,
    tooltip: tip,
    onPressed: () {
      final m = meta(s, tip);
      send(create(m));
    },
    icon: Icon(icon),
  );
}

String formatDuration(Duration d) =>
    '${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
