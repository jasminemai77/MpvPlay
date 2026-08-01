import 'dart:async';
import 'dart:io';

import 'package:media_kit/media_kit.dart';
import 'package:playback_engine_api/playback_engine_api.dart';
import 'package:player_core/player_core.dart';

final class MpvPlaybackEngine implements PlaybackEngine {
  final _events = StreamController<EngineEvent>.broadcast();
  final _subscriptions = <StreamSubscription<Object?>>[];
  Player? _player;
  int _generation = 0;
  double _volume = 1;
  bool _muted = false;
  bool _disposed = false;

  @override
  Stream<EngineEvent> get events => _events.stream;

  @override
  Future<EngineCapabilities> initialize() async {
    if (_disposed) throw StateError('Engine disposed');
    try {
      MediaKit.ensureInitialized();
      final player = Player();
      _player = player;
      _subscriptions
        ..add(
          player.stream.position.listen(
            (value) => _emit(EnginePositionChanged(_generation, value)),
          ),
        )
        ..add(
          player.stream.duration.listen(
            (value) => _emit(EngineDurationChanged(_generation, value)),
          ),
        )
        ..add(
          player.stream.playing.listen((playing) {
            _emit(
              EngineStateChanged(
                _generation,
                playing ? EngineState.playing : EngineState.paused,
              ),
            );
          }),
        )
        ..add(
          player.stream.completed.listen((completed) {
            if (completed) _emit(EngineCompleted(_generation));
          }),
        )
        ..add(
          player.stream.error.listen((message) {
            _emit(
              EngineFailed(
                _generation,
                EngineFailure(
                  EngineFailureKind.playback,
                  '播放发生错误',
                  details: message,
                ),
              ),
            );
          }),
        );
      return const EngineCapabilities();
    } catch (error) {
      throw StateError('libmpv initialization failed: $error');
    }
  }

  Player get _requiredPlayer =>
      _player ?? (throw StateError('Engine not initialized'));

  @override
  Future<void> load(
    MediaSource source, {
    Duration? startPosition,
    bool autoPlay = false,
    required int generation,
  }) async {
    _generation = generation;
    _emit(EngineStateChanged(generation, EngineState.loading));
    if (source.uri.scheme == 'file' &&
        !await File.fromUri(source.uri).exists()) {
      throw FileSystemException('File not found', source.uri.toFilePath());
    }
    try {
      await _requiredPlayer.open(Media(source.uri.toString()), play: autoPlay);
      if (startPosition != null && startPosition > Duration.zero) {
        await _requiredPlayer.seek(startPosition);
      }
      _emit(
        EngineStateChanged(
          generation,
          autoPlay ? EngineState.playing : EngineState.ready,
        ),
      );
    } catch (error) {
      throw StateError('Media load failed: $error');
    }
  }

  @override
  Future<void> play() => _requiredPlayer.play();
  @override
  Future<void> pause() => _requiredPlayer.pause();
  @override
  Future<void> stop() => _requiredPlayer.stop();
  @override
  Future<void> seek(Duration position) => _requiredPlayer.seek(position);
  @override
  Future<void> setVolume(double value) async {
    _volume = value.clamp(0, 1).toDouble();
    if (!_muted) await _requiredPlayer.setVolume(_volume * 100);
  }

  @override
  Future<void> setMuted(bool muted) async {
    _muted = muted;
    await _requiredPlayer.setVolume(muted ? 0 : _volume * 100);
  }

  void _emit(EngineEvent event) {
    if (!_disposed) _events.add(event);
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _player?.dispose();
    await _events.close();
  }
}
