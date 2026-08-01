// The public constructor names intentionally differ from private fields.
// ignore_for_file: prefer_initializing_formals

import 'dart:async';
import 'dart:io';

import 'package:playback_engine_api/playback_engine_api.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:player_core/player_core.dart';

abstract interface class PlaybackClient {
  Stream<PlaybackSnapshot> get snapshots;
  Stream<PlaybackEvent> get events;
  Future<void> send(PlaybackCommand command);
  Future<void> dispose();
}

/// A small structured record.  Sinks must not throw back into playback.
final class PlaybackLogRecord {
  const PlaybackLogRecord({
    required this.sessionId,
    required this.snapshotRevision,
    required this.loadGeneration,
    required this.playbackStatus,
    this.commandId,
    this.commandType,
    this.engineEventType,
    this.currentItemId,
    this.errorCode,
  });

  final String sessionId;
  final int snapshotRevision;
  final int loadGeneration;
  final PlaybackStatus playbackStatus;
  final String? commandId;
  final String? commandType;
  final String? engineEventType;
  final String? currentItemId;
  final PlaybackFailureCode? errorCode;
}

typedef PlaybackLogSink = void Function(PlaybackLogRecord record);

final class InProcessPlaybackClient implements PlaybackClient {
  InProcessPlaybackClient(this.runtime);
  final PlaybackRuntime runtime;

  @override
  Stream<PlaybackSnapshot> get snapshots => runtime.snapshots;
  @override
  Stream<PlaybackEvent> get events => runtime.events;
  @override
  Future<void> send(PlaybackCommand command) => runtime.send(command);
  @override
  Future<void> dispose() => runtime.dispose();
}

/// The sole owner of queue and observed playback state for one process.
final class PlaybackRuntime {
  PlaybackRuntime({
    required PlaybackEngine engine,
    String? sessionId,
    PlaybackLogSink? logSink,
  }) : _engine = engine,
       _logSink = logSink,
       runtimeSessionId = sessionId ?? _newSessionId(),
       _snapshot = PlaybackSnapshot(
         sessionId: sessionId ?? _newSessionId(),
         revision: 0,
         status: PlaybackStatus.idle,
         currentItem: null,
         position: Duration.zero,
         duration: Duration.zero,
         queueItems: const [],
         currentIndex: -1,
         volume: 1,
         muted: false,
         failure: null,
       ) {
    _snapshot = _copy(sessionId: runtimeSessionId);
  }

  static String _newSessionId() =>
      DateTime.now().microsecondsSinceEpoch.toString();

  final PlaybackEngine _engine;
  final PlaybackLogSink? _logSink;
  final String runtimeSessionId;
  final _snapshotController = StreamController<PlaybackSnapshot>.broadcast();
  final _eventController = StreamController<PlaybackEvent>.broadcast();
  late final StreamSubscription<EngineEvent> _engineSubscription;
  late PlaybackSnapshot _snapshot;
  Future<void> _tail = Future.value();

  /// Public for diagnostic tests only; it is never UI state.
  int loadGeneration = 0;
  int snapshotRevision = 0;
  bool disposedFlag = false;
  bool _started = false;

  PlaybackSnapshot get currentSnapshot => _snapshot;
  Stream<PlaybackSnapshot> get snapshots => _snapshotController.stream;
  Stream<PlaybackEvent> get events => _eventController.stream;

  /// Used by the bootstrapper after it has validated a persisted session.
  void reportSessionRestored({
    required int restoredItems,
    int skippedItems = 0,
  }) {
    if (!disposedFlag) {
      _eventController.add(
        SessionRestored(restoredItems, skippedItems: skippedItems),
      );
    }
  }

  Future<void> initialize() async {
    if (_started) return;
    _started = true;
    _engineSubscription = _engine.events.listen(_onEngineEvent);
    try {
      await _engine.initialize();
      _publish(status: PlaybackStatus.idle);
    } catch (error, stack) {
      _fail(
        PlaybackFailureCode.engineInitializationFailed,
        'The playback engine could not be initialized.',
        error,
        stack,
        false,
      );
    }
  }

  Future<void> send(PlaybackCommand command) {
    if (disposedFlag) return Future.error(StateError('RuntimeDisposed'));
    if (!_started) return Future.error(StateError('RuntimeNotInitialized'));
    if (command.sessionId != runtimeSessionId) {
      return Future.error(
        ArgumentError('Command session does not match runtime session'),
      );
    }
    final operation = _tail.then((_) => _handle(command));
    _tail = operation.catchError((_) {});
    return operation;
  }

  Future<void> _handle(PlaybackCommand command) async {
    _log(command: command);
    try {
      switch (command) {
        case LoadQueue():
          await _loadQueue(command);
        case Play():
          if (_snapshot.currentItem != null) await _engine.play();
        case Pause():
          if (_snapshot.currentItem != null) await _engine.pause();
        case Stop():
          if (_snapshot.currentItem != null) await _engine.stop();
        case Seek():
          await _seek(command.position);
        case SkipNext():
          await _move(1);
        case SkipPrevious():
          await _move(-1);
        case SelectQueueItem():
          if (command.index < 0 ||
              command.index >= _snapshot.queueItems.length) {
            _failInvalidQueue('The selected queue item does not exist.');
            return;
          }
          _snapshot = _copy(
            currentIndex: command.index,
            currentItem: _snapshot.queueItems[command.index],
          );
          await _loadCurrent(autoPlay: true);
        case SetVolume():
          final value = command.value.clamp(0.0, 1.0).toDouble();
          await _engine.setVolume(value);
          _publish(volume: value);
        case SetMuted():
          await _engine.setMuted(command.muted);
          _publish(muted: command.muted);
      }
    } on RangeError catch (error, stack) {
      _fail(
        PlaybackFailureCode.invalidQueueState,
        'The playback queue is invalid.',
        error,
        stack,
        true,
      );
    } catch (error, stack) {
      _fail(
        PlaybackFailureCode.unknownFailure,
        'The playback operation could not be completed.',
        error,
        stack,
        true,
      );
    }
  }

  Future<void> _loadQueue(LoadQueue command) async {
    final items = List<PlayableItem>.unmodifiable(command.items);
    if (items.isEmpty) {
      ++loadGeneration;
      _snapshot = PlaybackSnapshot(
        sessionId: runtimeSessionId,
        revision: _snapshot.revision,
        status: PlaybackStatus.idle,
        currentItem: null,
        position: Duration.zero,
        duration: Duration.zero,
        queueItems: items,
        currentIndex: -1,
        volume: _snapshot.volume,
        muted: _snapshot.muted,
        failure: null,
      );
      _publish();
      return;
    }
    if (command.initialIndex < 0 || command.initialIndex >= items.length) {
      throw RangeError.index(command.initialIndex, items, 'initialIndex');
    }
    _snapshot = _copy(
      queueItems: items,
      currentIndex: command.initialIndex,
      currentItem: items[command.initialIndex],
    );
    await _loadCurrent(
      startPosition: command.startPosition,
      autoPlay: command.autoPlay,
    );
  }

  Future<void> _seek(Duration requested) async {
    if (_snapshot.currentItem == null ||
        _snapshot.status == PlaybackStatus.loading) {
      return;
    }
    final duration = _snapshot.duration;
    final position = requested < Duration.zero
        ? Duration.zero
        : duration > Duration.zero && requested > duration
        ? duration
        : requested;
    await _engine.seek(position);
  }

  Future<void> _loadCurrent({
    Duration? startPosition,
    bool autoPlay = true,
  }) async {
    final item = _snapshot.currentItem;
    if (item == null) return;
    final generation = ++loadGeneration;
    _publish(
      status: PlaybackStatus.loading,
      position: Duration.zero,
      duration: Duration.zero,
      clearFailure: true,
    );
    _eventController.add(TrackChanged(item));
    try {
      await _engine.load(
        item.source,
        startPosition: startPosition,
        autoPlay: autoPlay,
        generation: generation,
      );
    } on FileSystemException catch (error, stack) {
      if (generation == loadGeneration && !disposedFlag) {
        _fail(
          PlaybackFailureCode.fileNotFound,
          'The selected file is no longer available.',
          error,
          stack,
          true,
        );
      }
    } catch (error, stack) {
      if (generation == loadGeneration && !disposedFlag) {
        _fail(
          PlaybackFailureCode.mediaLoadFailed,
          'Unable to load “${item.title}”.',
          error,
          stack,
          true,
        );
      }
    }
  }

  Future<void> _move(int delta) async {
    if (_snapshot.queueItems.isEmpty) return;
    final next = _snapshot.currentIndex + delta;
    if (next < 0) return;
    if (next >= _snapshot.queueItems.length) {
      _publish(status: PlaybackStatus.completed);
      _eventController.add(const QueueCompleted());
      return;
    }
    _snapshot = _copy(
      currentIndex: next,
      currentItem: _snapshot.queueItems[next],
    );
    await _loadCurrent(autoPlay: true);
  }

  void _onEngineEvent(EngineEvent event) {
    if (disposedFlag || event.generation != loadGeneration) return;
    _log(engineEvent: event);
    switch (event) {
      case EngineStateChanged():
        _publish(status: PlaybackStatus.values[event.state.index]);
      case EnginePositionChanged():
        _publish(position: event.position);
      case EngineDurationChanged():
        _publish(duration: event.duration);
      case EngineCompleted():
        unawaited(
          send(
            SkipNext(
              commandId:
                  'auto-${event.generation}-${DateTime.now().microsecondsSinceEpoch}',
              sessionId: runtimeSessionId,
              issuedAt: DateTime.now(),
            ),
          ),
        );
      case EngineFailed():
        _fail(
          _failureCode(event.failure.kind),
          event.failure.message,
          event.failure.details,
          StackTrace.current,
          event.failure.recoverable,
        );
    }
  }

  PlaybackFailureCode _failureCode(EngineFailureKind value) => switch (value) {
    EngineFailureKind.fileNotFound => PlaybackFailureCode.fileNotFound,
    EngineFailureKind.unsupportedFormat =>
      PlaybackFailureCode.unsupportedFormat,
    EngineFailureKind.permissionDenied => PlaybackFailureCode.permissionDenied,
    EngineFailureKind.initialization =>
      PlaybackFailureCode.engineInitializationFailed,
    EngineFailureKind.load => PlaybackFailureCode.mediaLoadFailed,
    EngineFailureKind.playback => PlaybackFailureCode.playbackFailed,
    EngineFailureKind.unknown => PlaybackFailureCode.unknownFailure,
  };

  void _failInvalidQueue(String message) {
    _fail(
      PlaybackFailureCode.invalidQueueState,
      message,
      null,
      StackTrace.current,
      true,
    );
  }

  void _fail(
    PlaybackFailureCode code,
    String message,
    Object? details,
    StackTrace stack,
    bool recoverable,
  ) {
    final failure = PlaybackFailure(
      code: code,
      message: message,
      recoverable: recoverable,
      technicalDetails: '$details\n$stack',
    );
    _publish(status: PlaybackStatus.failed, failure: failure);
    _eventController.add(PlaybackFailed(failure));
    _log(errorCode: code);
  }

  void _publish({
    PlaybackStatus? status,
    PlayableItem? currentItem,
    Duration? position,
    Duration? duration,
    List<PlayableItem>? queueItems,
    int? currentIndex,
    double? volume,
    bool? muted,
    PlaybackFailure? failure,
    bool clearFailure = false,
  }) {
    if (disposedFlag) return;
    _snapshot = _copy(
      revision: ++snapshotRevision,
      status: status,
      currentItem: currentItem,
      position: position,
      duration: duration,
      queueItems: queueItems,
      currentIndex: currentIndex,
      volume: volume,
      muted: muted,
      failure: failure,
      clearFailure: clearFailure,
    );
    _snapshotController.add(_snapshot);
    _log();
  }

  PlaybackSnapshot _copy({
    String? sessionId,
    int? revision,
    PlaybackStatus? status,
    PlayableItem? currentItem,
    Duration? position,
    Duration? duration,
    List<PlayableItem>? queueItems,
    int? currentIndex,
    double? volume,
    bool? muted,
    PlaybackFailure? failure,
    bool clearFailure = false,
  }) => PlaybackSnapshot(
    sessionId: sessionId ?? _snapshot.sessionId,
    revision: revision ?? _snapshot.revision,
    status: status ?? _snapshot.status,
    currentItem: currentItem ?? _snapshot.currentItem,
    position: position ?? _snapshot.position,
    duration: duration ?? _snapshot.duration,
    queueItems: queueItems ?? _snapshot.queueItems,
    currentIndex: currentIndex ?? _snapshot.currentIndex,
    volume: volume ?? _snapshot.volume,
    muted: muted ?? _snapshot.muted,
    failure: clearFailure ? null : failure ?? _snapshot.failure,
  );

  void _log({
    PlaybackCommand? command,
    EngineEvent? engineEvent,
    PlaybackFailureCode? errorCode,
  }) {
    try {
      _logSink?.call(
        PlaybackLogRecord(
          sessionId: runtimeSessionId,
          snapshotRevision: _snapshot.revision,
          loadGeneration: loadGeneration,
          playbackStatus: _snapshot.status,
          commandId: command?.commandId,
          commandType: command?.runtimeType.toString(),
          engineEventType: engineEvent?.runtimeType.toString(),
          currentItemId: _snapshot.currentItem?.id,
          errorCode: errorCode,
        ),
      );
    } catch (_) {
      // Logging must never destabilize playback.
    }
  }

  Future<void> dispose() async {
    if (disposedFlag) return;
    disposedFlag = true;
    ++loadGeneration;
    if (_started) await _engineSubscription.cancel();
    await _engine.dispose();
    _snapshot = PlaybackSnapshot(
      sessionId: runtimeSessionId,
      revision: ++snapshotRevision,
      status: PlaybackStatus.disposed,
      currentItem: _snapshot.currentItem,
      position: _snapshot.position,
      duration: _snapshot.duration,
      queueItems: _snapshot.queueItems,
      currentIndex: _snapshot.currentIndex,
      volume: _snapshot.volume,
      muted: _snapshot.muted,
      failure: _snapshot.failure,
    );
    _snapshotController.add(_snapshot);
    _log();
    await _snapshotController.close();
    await _eventController.close();
  }
}
