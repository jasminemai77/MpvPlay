import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playback_engine_mpv/playback_engine_mpv.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:platform_bridge/platform_bridge.dart';

import '../app/mpv_play_app.dart';
import '../features/now_playing/application/playback_providers.dart';

final class AppBootstrap {
  AppBootstrap._(this._client, this._initialSnapshot);
  final PlaybackClient _client;
  final PlaybackSnapshot _initialSnapshot;

  static Future<AppBootstrap> create() async {
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
    return AppBootstrap._(
      InProcessPlaybackClient(runtime),
      runtime.currentSnapshot,
    );
  }

  Widget buildApp() => ProviderScope(
    overrides: [
      clientProvider.overrideWithValue(_client),
      initialSnapshotProvider.overrideWithValue(_initialSnapshot),
    ],
    child: const MpvPlayApp(),
  );
}
