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

/// Runtime-owned completion policy.  UI never interprets completion events.
enum RepeatMode { off, all, one }

enum PlaybackFailureCode {
  fileNotFound,
  unsupportedFormat,
  permissionDenied,
  engineInitializationFailed,
  mediaLoadFailed,
  playbackFailed,
  invalidCommand,
  invalidQueueState,
  queueEntryNotFound,
  invalidQueueIndex,
  emptyQueue,
  sessionRestoreFailure,
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

/// An occurrence in a queue. Identical tracks may deliberately have distinct ids.
final class PlaybackQueueEntry {
  const PlaybackQueueEntry({required this.entryId, required this.item});
  final String entryId;
  final PlayableItem item;
  @override
  bool operator ==(Object other) =>
      other is PlaybackQueueEntry &&
      other.entryId == entryId &&
      other.item == item;
  @override
  int get hashCode => Object.hash(entryId, item);
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

final class RestoreQueue extends PlaybackCommand {
  const RestoreQueue({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.entries,
    required this.currentEntryId,
    required this.playOrderEntryIds,
    this.repeatMode = RepeatMode.off,
    this.shuffleEnabled = false,
    this.startPosition,
  });
  final List<PlaybackQueueEntry> entries;
  final String? currentEntryId;
  final List<String> playOrderEntryIds;
  final RepeatMode repeatMode;
  final bool shuffleEnabled;
  final Duration? startPosition;
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

/// Legacy index command retained for source compatibility; new UI uses entry identity.
final class SelectQueueItem extends PlaybackCommand {
  const SelectQueueItem({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.index,
  });
  final int index;
}

final class PlayQueueEntry extends PlaybackCommand {
  const PlayQueueEntry({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.entryId,
  });
  final String entryId;
}

final class AppendToQueue extends PlaybackCommand {
  const AppendToQueue({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.items,
  });
  final List<PlayableItem> items;
}

final class InsertNext extends PlaybackCommand {
  const InsertNext({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.items,
  });
  final List<PlayableItem> items;
}

final class RemoveQueueEntry extends PlaybackCommand {
  const RemoveQueueEntry({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.entryId,
  });
  final String entryId;
}

final class MoveQueueEntry extends PlaybackCommand {
  const MoveQueueEntry({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.entryId,
    required this.targetIndex,
  });
  final String entryId;
  final int targetIndex;
}

final class ClearQueue extends PlaybackCommand {
  const ClearQueue({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
  });
}

final class SetShuffleEnabled extends PlaybackCommand {
  const SetShuffleEnabled({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.enabled,
  });
  final bool enabled;
}

final class SetRepeatMode extends PlaybackCommand {
  const SetRepeatMode({
    required super.commandId,
    required super.sessionId,
    required super.issuedAt,
    required this.repeatMode,
  });
  final RepeatMode repeatMode;
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
    List<PlaybackQueueEntry>? queueEntries,
    List<String>? playOrderEntryIds,
    this.currentEntryId,
    this.repeatMode = RepeatMode.off,
    this.shuffleEnabled = false,
  }) : queueItems = List.unmodifiable(queueItems),
       queueEntries = List.unmodifiable(queueEntries ?? const []),
       playOrderEntryIds = List.unmodifiable(playOrderEntryIds ?? const []);
  final String sessionId;
  final int revision;
  final PlaybackStatus status;
  final PlayableItem? currentItem;
  final Duration position;
  final Duration duration;

  /// Actual runtime play order, retained for existing consumers.
  final List<PlayableItem> queueItems;
  final int currentIndex;
  final double volume;
  final bool muted;
  final PlaybackFailure? failure;
  final List<PlaybackQueueEntry> queueEntries;
  final List<String> playOrderEntryIds;
  final String? currentEntryId;
  final RepeatMode repeatMode;
  final bool shuffleEnabled;
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
