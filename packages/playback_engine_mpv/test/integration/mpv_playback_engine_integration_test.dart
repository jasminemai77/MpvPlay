import 'dart:async';
import 'dart:io';

import 'package:playback_engine_api/playback_engine_api.dart';
import 'package:playback_engine_mpv/playback_engine_mpv.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:player_core/player_core.dart';
import 'package:test/test.dart';

final _fixtureDirectory = Directory('test_media/generated').absolute;

MediaSource _source(String name) {
  final file = File(
    '${_fixtureDirectory.path}${Platform.pathSeparator}$name',
  ).absolute;
  return MediaSource(id: name, uri: file.uri, kind: MediaKind.audio);
}

PlayableItem _item(String name) =>
    PlayableItem(id: name, title: name, source: _source(name));

Future<void> _waitUntil(
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 8),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw TimeoutException('Condition was not met within $timeout.');
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

Future<void> _load(MpvPlaybackEngine engine, String fixture, int generation) =>
    engine.load(_source(fixture), generation: generation);

void main() {
  setUpAll(() {
    if (!_fixtureDirectory.existsSync()) {
      throw StateError(
        'Run tools/test_media_generator/generate.dart before this suite.',
      );
    }
  });

  group('real libmpv integration with null audio output', () {
    test(
      'initializes and loads a legal WAV with a positive duration',
      () async {
        final engine = MpvPlaybackEngine(
          configuration: const MpvEngineConfiguration(enableAudioOutput: false),
        );
        final events = <EngineEvent>[];
        final subscription = engine.events.listen(events.add);
        try {
          final capabilities = await engine.initialize();
          expect(capabilities.canSeek, isTrue);
          await _load(engine, 'tone-440hz.wav', 1);
          await engine.play();
          await _waitUntil(
            () => events.whereType<EngineDurationChanged>().any(
              (event) =>
                  event.generation == 1 && event.duration > Duration.zero,
            ),
          );
          final duration = events
              .whereType<EngineDurationChanged>()
              .last
              .duration;
          expect(duration, greaterThan(const Duration(seconds: 4)));
          expect(duration, lessThan(const Duration(seconds: 6)));
        } finally {
          await subscription.cancel();
          await engine.dispose();
        }
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );

    test(
      'plays, pauses, seeks, and stops real WAV playback',
      () async {
        final engine = MpvPlaybackEngine(
          configuration: const MpvEngineConfiguration(enableAudioOutput: false),
        );
        final events = <EngineEvent>[];
        final subscription = engine.events.listen(events.add);
        try {
          await engine.initialize();
          await _load(engine, 'tone-440hz.wav', 2);
          await engine.play();
          await _waitUntil(
            () => events.whereType<EnginePositionChanged>().any(
              (event) =>
                  event.generation == 2 &&
                  event.position > const Duration(milliseconds: 250),
            ),
          );
          await engine.pause();
          final beforePause = events
              .whereType<EnginePositionChanged>()
              .last
              .position;
          await Future<void>.delayed(const Duration(milliseconds: 350));
          final afterPause = events
              .whereType<EnginePositionChanged>()
              .last
              .position;
          expect(
            afterPause - beforePause,
            lessThan(const Duration(milliseconds: 300)),
          );
          await engine.seek(const Duration(milliseconds: 2500));
          await _waitUntil(
            () => events.whereType<EnginePositionChanged>().any(
              (event) =>
                  (event.position - const Duration(milliseconds: 2500)).abs() <
                  const Duration(milliseconds: 700),
            ),
          );
          await engine.stop();
          await _waitUntil(
            () => events.whereType<EngineStateChanged>().any(
              (event) =>
                  event.generation == 2 && event.state == EngineState.stopped,
            ),
          );
        } finally {
          await subscription.cancel();
          await engine.dispose();
        }
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );

    test(
      'emits completion for short real WAV playback',
      () async {
        final engine = MpvPlaybackEngine(
          configuration: const MpvEngineConfiguration(enableAudioOutput: false),
        );
        final events = <EngineEvent>[];
        final subscription = engine.events.listen(events.add);
        try {
          await engine.initialize();
          await _load(engine, 'short-tone.wav', 3);
          await engine.play();
          await _waitUntil(
            () => events.whereType<EngineCompleted>().any(
              (event) => event.generation == 3,
            ),
            timeout: const Duration(seconds: 6),
          );
        } finally {
          await subscription.cancel();
          await engine.dispose();
        }
      },
      timeout: const Timeout(Duration(seconds: 12)),
    );

    test(
      'corrupt input fails without preventing a later valid load',
      () async {
        final engine = MpvPlaybackEngine(
          configuration: const MpvEngineConfiguration(enableAudioOutput: false),
        );
        final events = <EngineEvent>[];
        final subscription = engine.events.listen(events.add);
        try {
          await engine.initialize();
          try {
            await _load(engine, 'random-bytes.bin', 4);
          } catch (_) {
            // Either a synchronous load rejection or an EngineFailed event is valid.
          }
          await _waitUntil(
            () => events.whereType<EngineFailed>().any(
              (event) => event.generation == 4,
            ),
          );
          await _load(engine, 'short-tone.wav', 5);
          await engine.play();
          await _waitUntil(
            () => events.whereType<EnginePositionChanged>().any(
              (event) =>
                  event.generation == 5 && event.position > Duration.zero,
            ),
          );
        } finally {
          await subscription.cancel();
          await engine.dispose();
        }
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );

    test(
      'runtime maps missing media and recovers with real engine',
      () async {
        final engine = MpvPlaybackEngine(
          configuration: const MpvEngineConfiguration(enableAudioOutput: false),
        );
        final runtime = PlaybackRuntime(
          engine: engine,
          sessionId: 'real-engine-test',
        );
        try {
          await runtime.initialize();
          final now = DateTime.now();
          await runtime.send(
            LoadQueue(
              commandId: 'missing',
              sessionId: runtime.runtimeSessionId,
              issuedAt: now,
              items: [_item('missing.wav')],
              autoPlay: true,
            ),
          );
          expect(
            runtime.currentSnapshot.failure?.code,
            PlaybackFailureCode.fileNotFound,
          );
          await runtime.send(
            LoadQueue(
              commandId: 'valid',
              sessionId: runtime.runtimeSessionId,
              issuedAt: DateTime.now(),
              items: [_item('short-tone.wav')],
              autoPlay: true,
            ),
          );
          await _waitUntil(
            () => runtime.currentSnapshot.position > Duration.zero,
          );
          expect(runtime.currentSnapshot.failure, isNull);
        } finally {
          await runtime.dispose();
        }
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );

    test('dispose is idempotent and rejects later engine operations', () async {
      final engine = MpvPlaybackEngine(
        configuration: const MpvEngineConfiguration(),
      );
      await engine.initialize();
      await engine.dispose();
      await engine.dispose();
      expect(() => engine.play(), throwsStateError);
    });
  });
}
