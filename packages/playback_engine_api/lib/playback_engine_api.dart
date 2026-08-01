import 'package:player_core/player_core.dart';

final class EngineCapabilities {
  const EngineCapabilities({
    this.canSeek = true,
    this.canSetVolume = true,
    this.canMute = true,
  });
  final bool canSeek;
  final bool canSetVolume;
  final bool canMute;
}

enum EngineState {
  idle,
  loading,
  ready,
  playing,
  paused,
  stopped,
  completed,
  failed,
  disposed,
}

enum EngineFailureKind {
  fileNotFound,
  unsupportedFormat,
  permissionDenied,
  initialization,
  load,
  playback,
  unknown,
}

final class EngineFailure {
  const EngineFailure(
    this.kind,
    this.message, {
    this.details,
    this.recoverable = true,
  });
  final EngineFailureKind kind;
  final String message;
  final String? details;
  final bool recoverable;
}

sealed class EngineEvent {
  const EngineEvent(this.generation);
  final int generation;
}

final class EngineStateChanged extends EngineEvent {
  const EngineStateChanged(super.generation, this.state);
  final EngineState state;
}

final class EnginePositionChanged extends EngineEvent {
  const EnginePositionChanged(super.generation, this.position);
  final Duration position;
}

final class EngineDurationChanged extends EngineEvent {
  const EngineDurationChanged(super.generation, this.duration);
  final Duration duration;
}

final class EngineCompleted extends EngineEvent {
  const EngineCompleted(super.generation);
}

final class EngineFailed extends EngineEvent {
  const EngineFailed(super.generation, this.failure);
  final EngineFailure failure;
}

abstract interface class PlaybackEngine {
  Stream<EngineEvent> get events;
  Future<EngineCapabilities> initialize();
  Future<void> load(
    MediaSource source, {
    Duration? startPosition,
    bool autoPlay = false,
    required int generation,
  });
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> setVolume(double value);
  Future<void> setMuted(bool muted);
  Future<void> dispose();
}
