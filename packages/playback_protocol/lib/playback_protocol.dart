import 'package:player_core/player_core.dart';

enum PlaybackStatus {
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

enum PlaybackFailureCode {
  fileNotFound,
  unsupportedFormat,
  permissionDenied,
  engineInitializationFailed,
  mediaLoadFailed,
  playbackFailed,
  invalidCommand,
  invalidQueueState,
  runtimeDisposed,
  unknownFailure,
}

final class PlaybackFailure {
  const PlaybackFailure({
    required this.code,
    required this.message,
    required this.recoverable,
    this.technicalDetails,
  });
  final PlaybackFailureCode code;
  final String message;
  final bool recoverable;
  final String? technicalDetails;
}

sealed class PlaybackCommand {
  const PlaybackCommand({
    required this.commandId,
    required this.sessionId,
    required this.issuedAt,
  });
  final String commandId;
  final String sessionId;
  final DateTime issuedAt;
}

final class LoadQueue extends PlaybackCommand {
  const LoadQueue({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.items,
    this.initialIndex = 0,
    this.startPosition,
    this.autoPlay = false,
  });
  final List<PlayableItem> items;
  final int initialIndex;
  final Duration? startPosition;
  final bool autoPlay;
}

final class Play extends PlaybackCommand {
  const Play({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
  });
}

final class Pause extends PlaybackCommand {
  const Pause({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
  });
}

final class Stop extends PlaybackCommand {
  const Stop({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
  });
}

final class Seek extends PlaybackCommand {
  const Seek({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.position,
  });
  final Duration position;
}

final class SkipNext extends PlaybackCommand {
  const SkipNext({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
  });
}

final class SkipPrevious extends PlaybackCommand {
  const SkipPrevious({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
  });
}

final class SelectQueueItem extends PlaybackCommand {
  const SelectQueueItem({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.index,
  });
  final int index;
}

final class SetVolume extends PlaybackCommand {
  const SetVolume({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.value,
  });
  final double value;
}

final class SetMuted extends PlaybackCommand {
  const SetMuted({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.muted,
  });
  final bool muted;
}

final class PlaybackSnapshot {
  PlaybackSnapshot({
    required this.sessionId,
    required this.revision,
    required this.status,
    required this.currentItem,
    required this.position,
    required this.duration,
    required List<PlayableItem> queueItems,
    required this.currentIndex,
    required this.volume,
    required this.muted,
    required this.failure,
  }) : queueItems = List.unmodifiable(queueItems);
  final String sessionId;
  final int revision;
  final PlaybackStatus status;
  final PlayableItem? currentItem;
  final Duration position;
  final Duration duration;
  final List<PlayableItem> queueItems;
  final int currentIndex;
  final double volume;
  final bool muted;
  final PlaybackFailure? failure;
}

sealed class PlaybackEvent {
  const PlaybackEvent();
}

final class TrackChanged extends PlaybackEvent {
  const TrackChanged(this.item);
  final PlayableItem item;
}

final class QueueCompleted extends PlaybackEvent {
  const QueueCompleted();
}

final class PlaybackFailed extends PlaybackEvent {
  const PlaybackFailed(this.failure);
  final PlaybackFailure failure;
}

final class SessionRestored extends PlaybackEvent {
  const SessionRestored(this.restoredItems, {this.skippedItems = 0});
  final int restoredItems;
  final int skippedItems;
}

final class InvalidQueueItemSkipped extends PlaybackEvent {
  const InvalidQueueItemSkipped(this.item);
  final PlayableItem item;
}
