import 'dart:async';
import 'package:playback_engine_api/playback_engine_api.dart';
import 'package:player_core/player_core.dart';

final class FakePlaybackEngine implements PlaybackEngine {
  final controller = StreamController<EngineEvent>.broadcast();
  final List<String> calls = [];
  bool failInitialize = false;
  bool failLoad = false;
  int generation = 0;
  @override
  Stream<EngineEvent> get events => controller.stream;
  @override
  Future<EngineCapabilities> initialize() async {
    calls.add('initialize');
    if (failInitialize) throw StateError('init');
    return const EngineCapabilities();
  }

  @override
  Future<void> load(
    MediaSource source, {
    Duration? startPosition,
    bool autoPlay = false,
    required int generation,
  }) async {
    calls.add('load:${source.id}:$generation:$autoPlay');
    this.generation = generation;
    if (failLoad) throw StateError('load');
    emit(EngineStateChanged(generation, EngineState.ready));
    if (autoPlay) emit(EngineStateChanged(generation, EngineState.playing));
  }

  @override
  Future<void> play() async {
    calls.add('play');
    emit(EngineStateChanged(generation, EngineState.playing));
  }

  @override
  Future<void> pause() async {
    calls.add('pause');
    emit(EngineStateChanged(generation, EngineState.paused));
  }

  @override
  Future<void> stop() async {
    calls.add('stop');
    emit(EngineStateChanged(generation, EngineState.stopped));
  }

  @override
  Future<void> seek(Duration position) async {
    calls.add('seek:${position.inMilliseconds}');
    emit(EnginePositionChanged(generation, position));
  }

  @override
  Future<void> setVolume(double value) async {
    calls.add('volume:$value');
  }

  @override
  Future<void> setMuted(bool muted) async {
    calls.add('muted:$muted');
  }

  @override
  Future<void> dispose() async {
    calls.add('dispose');
    await controller.close();
  }

  void emit(EngineEvent event) => controller.add(event);
}
