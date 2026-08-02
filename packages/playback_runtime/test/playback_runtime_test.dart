import 'package:playback_engine_api/playback_engine_api.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/fake_playback_engine.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:player_core/player_core.dart';
import 'package:test/test.dart';

PlayableItem item(String id) => PlayableItem(
  id: id,
  title: id,
  source: MediaSource(
    id: id,
    uri: Uri.file('C:/$id.mp3'),
    kind: MediaKind.audio,
  ),
);

PlaybackCommand command(PlaybackRuntime runtime, String type, {Object? value}) {
  final common = (
    commandId: '$type-${DateTime.now().microsecondsSinceEpoch}',
    sessionId: runtime.runtimeSessionId,
    issuedAt: DateTime.now(),
  );
  return switch (type) {
    'load' => LoadQueue(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
      items: value! as List<PlayableItem>,
      autoPlay: true,
    ),
    'play' => Play(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
    ),
    'pause' => Pause(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
    ),
    'stop' => Stop(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
    ),
    'next' => SkipNext(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
    ),
    'seek' => Seek(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
      position: value! as Duration,
    ),
    'volume' => SetVolume(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
      value: value! as double,
    ),
    'muted' => SetMuted(
      commandId: common.commandId,
      sessionId: common.sessionId,
      issuedAt: common.issuedAt,
      muted: value! as bool,
    ),
    _ => throw ArgumentError(type),
  };
}

void main() {
  late FakePlaybackEngine engine;
  late PlaybackRuntime runtime;
  setUp(() async {
    engine = FakePlaybackEngine();
    runtime = PlaybackRuntime(engine: engine, sessionId: 'test');
    await runtime.initialize();
  });
  tearDown(() async {
    if (!runtime.disposedFlag) await runtime.dispose();
  });

  test('initializes idle and revisions increase', () async {
    expect(runtime.currentSnapshot.status, PlaybackStatus.idle);
    final revisions = <int>[];
    final sub = runtime.snapshots.listen((s) => revisions.add(s.revision));
    await runtime.send(command(runtime, 'load', value: [item('a')]));
    await Future<void>.delayed(Duration.zero);
    expect(runtime.currentSnapshot.status, PlaybackStatus.playing);
    expect(revisions, orderedEquals(revisions.toList()..sort()));
    expect(revisions.toSet().length, revisions.length);
    await sub.cancel();
  });

  test('play pause stop seek volume and mute flow through engine', () async {
    await runtime.send(command(runtime, 'load', value: [item('a')]));
    await runtime.send(command(runtime, 'pause'));
    expect(runtime.currentSnapshot.status, PlaybackStatus.paused);
    await runtime.send(command(runtime, 'play'));
    await runtime.send(
      command(runtime, 'seek', value: const Duration(seconds: 12)),
    );
    await runtime.send(command(runtime, 'volume', value: 4.0));
    await runtime.send(command(runtime, 'muted', value: true));
    await runtime.send(command(runtime, 'stop'));
    expect(runtime.currentSnapshot.status, PlaybackStatus.stopped);
    expect(runtime.currentSnapshot.volume, 1);
    expect(runtime.currentSnapshot.muted, isTrue);
    expect(
      engine.calls,
      containsAll([
        'pause',
        'play',
        'seek:12000',
        'volume:1.0',
        'muted:true',
        'stop',
      ]),
    );
  });

  test('completion advances and last item completes queue', () async {
    await runtime.send(command(runtime, 'load', value: [item('a'), item('b')]));
    engine.emit(EngineCompleted(engine.generation));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    expect(runtime.currentSnapshot.currentIndex, 1);
    engine.emit(EngineCompleted(engine.generation));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    expect(runtime.currentSnapshot.status, PlaybackStatus.completed);
  });

  test('stale generation events are ignored during rapid skip', () async {
    await runtime.send(
      command(runtime, 'load', value: [item('a'), item('b'), item('c')]),
    );
    final old = engine.generation;
    await runtime.send(command(runtime, 'next'));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    final revision = runtime.currentSnapshot.revision;
    engine.emit(EngineStateChanged(old, EngineState.failed));
    engine.emit(EngineCompleted(old));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    expect(runtime.currentSnapshot.currentIndex, 1);
    expect(runtime.currentSnapshot.revision, revision);
  });

  test('load failure is recoverable by loading another queue', () async {
    engine.failLoad = true;
    await runtime.send(command(runtime, 'load', value: [item('bad')]));
    expect(runtime.currentSnapshot.status, PlaybackStatus.failed);
    engine.failLoad = false;
    await runtime.send(command(runtime, 'load', value: [item('good')]));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    expect(runtime.currentSnapshot.status, PlaybackStatus.playing);
    expect(runtime.currentSnapshot.failure, isNull);
  });

  test('empty queue commands are safe and dispose rejects commands', () async {
    await runtime.send(command(runtime, 'load', value: <PlayableItem>[]));
    await runtime.send(command(runtime, 'next'));
    expect(runtime.currentSnapshot.status, PlaybackStatus.idle);
    await runtime.dispose();
    await expectLater(runtime.send(command(runtime, 'play')), throwsStateError);
  });

  test('a non-autoplay load reaches ready and can subsequently play', () async {
    final common = (
      commandId: 'ready',
      sessionId: runtime.runtimeSessionId,
      issuedAt: DateTime.now(),
    );
    await runtime.send(
      LoadQueue(
        commandId: common.commandId,
        sessionId: common.sessionId,
        issuedAt: common.issuedAt,
        items: [item('ready')],
        autoPlay: false,
      ),
    );
    await Future<void>.delayed(Duration.zero);
    expect(runtime.currentSnapshot.status, PlaybackStatus.ready);
    await runtime.send(command(runtime, 'play'));
    expect(runtime.currentSnapshot.status, PlaybackStatus.playing);
  });

  test(
    'engine failures are mapped and recovery retains a usable runtime',
    () async {
      await runtime.send(command(runtime, 'load', value: [item('a')]));
      engine.emit(
        EngineFailed(
          engine.generation,
          const EngineFailure(
            EngineFailureKind.unsupportedFormat,
            'unsupported',
          ),
        ),
      );
      await Future<void>.delayed(Duration.zero);
      expect(
        runtime.currentSnapshot.failure?.code,
        PlaybackFailureCode.unsupportedFormat,
      );
      await runtime.send(command(runtime, 'load', value: [item('b')]));
      await Future<void>.delayed(Duration.zero);
      expect(runtime.currentSnapshot.status, PlaybackStatus.playing);
      expect(runtime.currentSnapshot.failure, isNull);
    },
  );

  test('completion from a cleared queue generation is ignored', () async {
    await runtime.send(command(runtime, 'load', value: [item('a')]));
    final oldGeneration = engine.generation;
    await runtime.send(command(runtime, 'load', value: <PlayableItem>[]));
    engine.emit(EngineCompleted(oldGeneration));
    await Future<void>.delayed(Duration.zero);
    expect(runtime.currentSnapshot.status, PlaybackStatus.idle);
    expect(runtime.currentSnapshot.currentItem, isNull);
  });

  test('wrong-session commands are rejected without changing state', () async {
    final before = runtime.currentSnapshot.revision;
    await expectLater(
      runtime.send(
        Play(commandId: 'wrong', sessionId: 'other', issuedAt: DateTime.now()),
      ),
      throwsArgumentError,
    );
    expect(runtime.currentSnapshot.revision, before);
  });

  test('invalid queue selection enters a recoverable queue failure', () async {
    final common = (
      commandId: 'invalid-select',
      sessionId: runtime.runtimeSessionId,
      issuedAt: DateTime.now(),
    );
    await runtime.send(
      SelectQueueItem(
        commandId: common.commandId,
        sessionId: common.sessionId,
        issuedAt: common.issuedAt,
        index: 99,
      ),
    );
    expect(runtime.currentSnapshot.status, PlaybackStatus.failed);
    expect(
      runtime.currentSnapshot.failure?.code,
      PlaybackFailureCode.invalidQueueState,
    );
    expect(runtime.currentSnapshot.failure?.recoverable, isTrue);
  });

  test(
    'queue entries keep independent identities for duplicate tracks',
    () async {
      await runtime.send(
        command(runtime, 'load', value: [item('same'), item('same')]),
      );
      final snapshot = runtime.currentSnapshot;
      expect(snapshot.queueEntries, hasLength(2));
      expect(
        snapshot.queueEntries[0].entryId,
        isNot(snapshot.queueEntries[1].entryId),
      );
      expect(snapshot.currentEntryId, snapshot.queueEntries.first.entryId);
    },
  );

  test('repeat one reloads only for natural completion', () async {
    await runtime.send(command(runtime, 'load', value: [item('a'), item('b')]));
    final firstGeneration = engine.generation;
    await runtime.send(
      SetRepeatMode(
        commandId: 'one',
        sessionId: runtime.runtimeSessionId,
        issuedAt: DateTime.now(),
        repeatMode: RepeatMode.one,
      ),
    );
    engine.emit(EngineCompleted(firstGeneration));
    await Future<void>.delayed(Duration.zero);
    expect(runtime.currentSnapshot.currentItem?.id, 'a');
    await runtime.send(command(runtime, 'next'));
    expect(runtime.currentSnapshot.currentItem?.id, 'b');
  });

  test(
    'insert next is the actual immediate successor while shuffled',
    () async {
      await runtime.send(
        command(runtime, 'load', value: [item('a'), item('b'), item('c')]),
      );
      await runtime.send(
        SetShuffleEnabled(
          commandId: 'shuffle',
          sessionId: runtime.runtimeSessionId,
          issuedAt: DateTime.now(),
          enabled: true,
        ),
      );
      await runtime.send(
        InsertNext(
          commandId: 'insert',
          sessionId: runtime.runtimeSessionId,
          issuedAt: DateTime.now(),
          items: [item('x'), item('y')],
        ),
      );
      final snapshot = runtime.currentSnapshot;
      expect(
        snapshot.queueItems
            .skip(snapshot.currentIndex + 1)
            .take(2)
            .map((e) => e.id),
        orderedEquals(['x', 'y']),
      );
    },
  );
}
