// The runtime is deliberately the only mutable queue owner.
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:playback_engine_api/playback_engine_api.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:player_core/player_core.dart';

abstract interface class PlaybackClient {
  Stream<PlaybackSnapshot> get snapshots;
  Stream<PlaybackEvent> get events;
  Future<void> send(PlaybackCommand command);
  Future<void> dispose();
}

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

abstract interface class ShuffleStrategy {
  List<T> shuffle<T>(List<T> values);
}

final class RandomShuffleStrategy implements ShuffleStrategy {
  RandomShuffleStrategy([Random? random]) : _random = random ?? Random();
  final Random _random;
  @override
  List<T> shuffle<T>(List<T> values) {
    final result = List<T>.of(values);
    result.shuffle(_random);
    return result;
  }
}

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

final class PlaybackRuntime {
  PlaybackRuntime({
    required PlaybackEngine engine,
    String? sessionId,
    PlaybackLogSink? logSink,
    ShuffleStrategy? shuffleStrategy,
  }) : _engine = engine,
       _logSink = logSink,
       _shuffle = shuffleStrategy ?? RandomShuffleStrategy(),
       runtimeSessionId = sessionId ?? _newSessionId() {
    _snapshot = _makeSnapshot();
  }
  static String _newSessionId() =>
      DateTime.now().microsecondsSinceEpoch.toString();
  static String _uuidV7() {
    final ms = DateTime.now().millisecondsSinceEpoch;
    final random = Random.secure();
    String hex(int value, int digits) =>
        value.toRadixString(16).padLeft(digits, '0');
    return '${hex(ms, 12)}-7${hex(random.nextInt(0x1000), 3)}-${hex(0x8000 | random.nextInt(0x4000), 4)}-${hex(random.nextInt(0x10000), 4)}-${hex(random.nextInt(1 << 30), 8)}${hex(random.nextInt(1 << 10), 3)}';
  }

  final PlaybackEngine _engine;
  final PlaybackLogSink? _logSink;
  final ShuffleStrategy _shuffle;
  final String runtimeSessionId;
  final _snapshotController = StreamController<PlaybackSnapshot>.broadcast();
  final _eventController = StreamController<PlaybackEvent>.broadcast();
  late PlaybackSnapshot _snapshot;
  late StreamSubscription<EngineEvent> _engineSubscription;
  Future<void> _tail = Future.value();
  final List<PlaybackQueueEntry> _base = [];
  final List<String> _order = [];
  final List<String> _history = [];
  String? _currentId;
  int _cursor = -1;
  RepeatMode _repeat = RepeatMode.off;
  bool _shuffleEnabled = false;
  int loadGeneration = 0;
  int snapshotRevision = 0;
  bool disposedFlag = false;
  bool _started = false;
  PlaybackSnapshot get currentSnapshot => _snapshot;
  Stream<PlaybackSnapshot> get snapshots => _snapshotController.stream;
  Stream<PlaybackEvent> get events => _eventController.stream;
  void reportSessionRestored({
    required int restoredItems,
    int skippedItems = 0,
  }) {
    if (!disposedFlag)
      _eventController.add(
        SessionRestored(restoredItems, skippedItems: skippedItems),
      );
  }

  Future<void> initialize() async {
    if (_started) return;
    _started = true;
    _engineSubscription = _engine.events.listen(_onEngineEvent);
    try {
      await _engine.initialize();
      _publish(status: PlaybackStatus.idle);
    } catch (e, s) {
      _fail(
        PlaybackFailureCode.engineInitializationFailed,
        'The playback engine could not be initialized.',
        e,
        s,
        false,
      );
    }
  }

  Future<void> send(PlaybackCommand command) {
    if (disposedFlag) return Future.error(StateError('RuntimeDisposed'));
    if (!_started) return Future.error(StateError('RuntimeNotInitialized'));
    if (command.sessionId != runtimeSessionId)
      return Future.error(
        ArgumentError('Command session does not match runtime session'),
      );
    final operation = _tail.then((_) => _handle(command));
    _tail = operation.catchError((_) {});
    return operation;
  }

  Future<void> _handle(PlaybackCommand command) async {
    _log(command: command);
    try {
      switch (command) {
        case LoadQueue():
          await _replaceQueue(command);
        case RestoreQueue():
          await _restoreQueue(command);
        case Play():
          if (_currentId != null) await _engine.play();
        case Pause():
          if (_currentId != null) await _engine.pause();
        case Stop():
          if (_currentId != null) await _engine.stop();
        case Seek():
          await _seek(command.position);
        case SkipNext():
          await _next();
        case SkipPrevious():
          await _previous();
        case SelectQueueItem():
          if (command.index < 0 || command.index >= _order.length) {
            _queueFailure(
              PlaybackFailureCode.invalidQueueState,
              'The selected queue index does not exist.',
            );
          } else {
            await _select(_order[command.index]);
          }
        case PlayQueueEntry():
          await _select(command.entryId);
        case AppendToQueue():
          await _append(command.items);
        case InsertNext():
          await _insertNext(command.items);
        case RemoveQueueEntry():
          await _remove(command.entryId);
        case MoveQueueEntry():
          await _moveEntry(command.entryId, command.targetIndex);
        case ClearQueue():
          await _clear();
        case SetShuffleEnabled():
          await _setShuffle(command.enabled);
        case SetRepeatMode():
          _repeat = command.repeatMode;
          _publish();
        case SetVolume():
          final v = command.value.clamp(0.0, 1.0).toDouble();
          await _engine.setVolume(v);
          _publish(volume: v);
        case SetMuted():
          await _engine.setMuted(command.muted);
          _publish(muted: command.muted);
      }
    } on RangeError catch (e, s) {
      _fail(
        PlaybackFailureCode.invalidQueueState,
        'The playback queue is invalid.',
        e,
        s,
        true,
      );
    } catch (e, s) {
      _fail(
        PlaybackFailureCode.unknownFailure,
        'The playback operation could not be completed.',
        e,
        s,
        true,
      );
    }
  }

  Future<void> _replaceQueue(LoadQueue command) async {
    _base
      ..clear()
      ..addAll(
        command.items.map(
          (item) => PlaybackQueueEntry(entryId: _uuidV7(), item: item),
        ),
      );
    _order
      ..clear()
      ..addAll(_base.map((e) => e.entryId));
    _history.clear();
    _shuffleEnabled = false;
    _repeat = RepeatMode.off;
    if (_base.isEmpty) {
      _currentId = null;
      _cursor = -1;
      ++loadGeneration;
      _publish(
        status: PlaybackStatus.idle,
        position: Duration.zero,
        duration: Duration.zero,
        clearFailure: true,
      );
      return;
    }
    if (command.initialIndex < 0 || command.initialIndex >= _base.length)
      throw RangeError.index(command.initialIndex, _base, 'initialIndex');
    _cursor = command.initialIndex;
    _currentId = _order[_cursor];
    await _loadCurrent(
      startPosition: command.startPosition,
      autoPlay: command.autoPlay,
    );
  }

  Future<void> _restoreQueue(RestoreQueue command) async {
    final ids = command.entries.map((e) => e.entryId).toSet();
    if (ids.length != command.entries.length ||
        command.playOrderEntryIds.length != ids.length ||
        command.playOrderEntryIds.toSet().length != ids.length ||
        !command.playOrderEntryIds.every(ids.contains) ||
        (command.currentEntryId != null &&
            !ids.contains(command.currentEntryId))) {
      _queueFailure(
        PlaybackFailureCode.sessionRestoreFailure,
        'The saved queue is invalid.',
      );
      return;
    }
    _base
      ..clear()
      ..addAll(command.entries);
    _order
      ..clear()
      ..addAll(command.playOrderEntryIds);
    _currentId = command.currentEntryId;
    _cursor = _currentId == null ? -1 : _order.indexOf(_currentId!);
    _repeat = command.repeatMode;
    _shuffleEnabled = command.shuffleEnabled;
    _history.clear();
    if (_currentId == null) {
      _publish(status: PlaybackStatus.idle);
      return;
    }
    await _loadCurrent(startPosition: command.startPosition, autoPlay: false);
  }

  Future<void> _append(List<PlayableItem> items) async {
    if (items.isEmpty) return;
    final entries = items
        .map((e) => PlaybackQueueEntry(entryId: _uuidV7(), item: e))
        .toList();
    _base.addAll(entries);
    _order.addAll(entries.map((e) => e.entryId));
    if (_currentId == null) {
      _currentId = _order.first;
      _cursor = 0;
    }
    _publish();
  }

  Future<void> _insertNext(List<PlayableItem> items) async {
    if (items.isEmpty) return;
    final entries = items
        .map((e) => PlaybackQueueEntry(entryId: _uuidV7(), item: e))
        .toList();
    if (_currentId == null) {
      _base.addAll(entries);
      _order.addAll(entries.map((e) => e.entryId));
      _currentId = _order.first;
      _cursor = 0;
      _publish();
      return;
    }
    final baseAt = _base.indexWhere((e) => e.entryId == _currentId);
    _base.insertAll(baseAt + 1, entries);
    _order.insertAll(_cursor + 1, entries.map((e) => e.entryId));
    _publish();
  }

  Future<void> _remove(String id) async {
    final entry = _entry(id);
    if (entry == null) {
      _queueFailure(
        PlaybackFailureCode.queueEntryNotFound,
        'The queue entry does not exist.',
      );
      return;
    }
    final removedCurrent = id == _currentId;
    final oldCursor = _cursor;
    _base.removeWhere((e) => e.entryId == id);
    _order.remove(id);
    _history.removeWhere((e) => e == id);
    if (_base.isEmpty) {
      await _clear();
      return;
    }
    if (!removedCurrent) {
      _cursor = _order.indexOf(_currentId!);
      _publish();
      return;
    }
    final nextIndex = oldCursor < _order.length ? oldCursor : _order.length - 1;
    _currentId = _order[nextIndex];
    _cursor = nextIndex;
    final wasPlaying = _snapshot.status == PlaybackStatus.playing;
    await _loadCurrent(autoPlay: wasPlaying);
  }

  Future<void> _moveEntry(String id, int target) async {
    if (_entry(id) == null) {
      _queueFailure(
        PlaybackFailureCode.queueEntryNotFound,
        'The queue entry does not exist.',
      );
      return;
    }
    if (target < 0 || target >= _base.length) {
      _queueFailure(
        PlaybackFailureCode.invalidQueueIndex,
        'The target queue index does not exist.',
      );
      return;
    }
    final current = _currentId;
    final baseIndex = _base.indexWhere((e) => e.entryId == id);
    final value = _base.removeAt(baseIndex);
    _base.insert(target, value);
    if (!_shuffleEnabled) {
      _order
        ..clear()
        ..addAll(_base.map((e) => e.entryId));
    }
    _cursor = current == null ? -1 : _order.indexOf(current);
    _publish();
  }

  Future<void> _clear() async {
    _base.clear();
    _order.clear();
    _history.clear();
    _currentId = null;
    _cursor = -1;
    ++loadGeneration;
    await _engine.stop();
    _publish(
      status: PlaybackStatus.idle,
      position: Duration.zero,
      duration: Duration.zero,
      clearFailure: true,
    );
  }

  Future<void> _setShuffle(bool enabled) async {
    if (_shuffleEnabled == enabled) return;
    _shuffleEnabled = enabled;
    if (_currentId == null) {
      _publish();
      return;
    }
    if (enabled) {
      final future = _base
          .map((e) => e.entryId)
          .where((id) => id != _currentId && !_history.contains(id))
          .toList();
      final prior = _history.where((id) => id != _currentId).toList();
      _order
        ..clear()
        ..addAll(prior)
        ..add(_currentId!)
        ..addAll(_shuffle.shuffle(future));
      _cursor = prior.length;
    } else {
      _order
        ..clear()
        ..addAll(_base.map((e) => e.entryId));
      _cursor = _order.indexOf(_currentId!);
    }
    _publish();
  }

  Future<void> _select(String id) async {
    if (_entry(id) == null) {
      _queueFailure(
        PlaybackFailureCode.queueEntryNotFound,
        'The queue entry does not exist.',
      );
      return;
    }
    if (_currentId != id && _currentId != null) _history.add(_currentId!);
    _currentId = id;
    _cursor = _order.indexOf(id);
    await _loadCurrent(autoPlay: true);
  }

  Future<void> _next({bool natural = false}) async {
    if (_currentId == null) {
      return;
    }
    if (natural && _repeat == RepeatMode.one) {
      await _loadCurrent(autoPlay: true);
      return;
    }
    if (_cursor + 1 < _order.length) {
      _history.add(_currentId!);
      _cursor++;
      _currentId = _order[_cursor];
      await _loadCurrent(autoPlay: true);
      return;
    }
    if (_repeat == RepeatMode.all) {
      final previous = _currentId;
      if (_shuffleEnabled && _base.length > 1) {
        final ids = _base.map((e) => e.entryId).toList();
        var order = _shuffle.shuffle(ids);
        if (order.first == previous) order = [...order.skip(1), order.first];
        _order
          ..clear()
          ..addAll(order);
      }
      _cursor = 0;
      _currentId = _order.first;
      _history.add(previous!);
      await _loadCurrent(autoPlay: true);
      return;
    }
    _publish(status: PlaybackStatus.completed);
    _eventController.add(const QueueCompleted());
  }

  Future<void> _previous() async {
    if (_currentId == null) {
      return;
    }
    final prior = _history.isNotEmpty
        ? _history.removeLast()
        : (_cursor > 0 ? _order[_cursor - 1] : null);
    if (prior == null) return;
    _currentId = prior;
    _cursor = _order.indexOf(prior);
    await _loadCurrent(autoPlay: true);
  }

  Future<void> _seek(Duration requested) async {
    if (_currentId == null || _snapshot.status == PlaybackStatus.loading)
      return;
    final duration = _snapshot.duration;
    final position = requested < Duration.zero
        ? Duration.zero
        : duration > Duration.zero && requested > duration
        ? duration
        : requested;
    await _engine.seek(position);
  }

  PlaybackQueueEntry? _entry(String id) {
    for (final e in _base) {
      if (e.entryId == id) return e;
    }
    return null;
  }

  Future<void> _loadCurrent({
    Duration? startPosition,
    bool autoPlay = true,
  }) async {
    final entry = _currentId == null ? null : _entry(_currentId!);
    if (entry == null) return;
    final generation = ++loadGeneration;
    _publish(
      status: PlaybackStatus.loading,
      position: Duration.zero,
      duration: Duration.zero,
      clearFailure: true,
    );
    _eventController.add(TrackChanged(entry.item));
    try {
      await _engine.load(
        entry.item.source,
        startPosition: startPosition,
        autoPlay: autoPlay,
        generation: generation,
      );
    } on FileSystemException catch (e, s) {
      if (generation == loadGeneration)
        _fail(
          PlaybackFailureCode.fileNotFound,
          'The selected file is no longer available.',
          e,
          s,
          true,
        );
    } catch (e, s) {
      if (generation == loadGeneration)
        _fail(
          PlaybackFailureCode.mediaLoadFailed,
          'Unable to load ${entry.item.title}.',
          e,
          s,
          true,
        );
    }
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
        unawaited(_next(natural: true));
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

  PlaybackFailureCode _failureCode(EngineFailureKind v) => switch (v) {
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
  void _queueFailure(PlaybackFailureCode code, String message) =>
      _fail(code, message, null, StackTrace.current, true);
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

  PlaybackSnapshot _makeSnapshot({
    PlaybackStatus status = PlaybackStatus.idle,
    Duration position = Duration.zero,
    Duration duration = Duration.zero,
    double volume = 1,
    bool muted = false,
    PlaybackFailure? failure,
  }) {
    final ordered = _order.map(_entry).whereType<PlaybackQueueEntry>().toList();
    return PlaybackSnapshot(
      sessionId: runtimeSessionId,
      revision: snapshotRevision,
      status: status,
      currentItem: _currentId == null ? null : _entry(_currentId!)?.item,
      position: position,
      duration: duration,
      queueItems: ordered.map((e) => e.item).toList(),
      queueEntries: ordered,
      playOrderEntryIds: _order,
      currentEntryId: _currentId,
      currentIndex: _cursor,
      repeatMode: _repeat,
      shuffleEnabled: _shuffleEnabled,
      volume: volume,
      muted: muted,
      failure: failure,
    );
  }

  void _publish({
    PlaybackStatus? status,
    Duration? position,
    Duration? duration,
    double? volume,
    bool? muted,
    PlaybackFailure? failure,
    bool clearFailure = false,
  }) {
    if (disposedFlag) return;
    _snapshot = _makeSnapshot(
      status: status ?? _snapshot.status,
      position: position ?? _snapshot.position,
      duration: duration ?? _snapshot.duration,
      volume: volume ?? _snapshot.volume,
      muted: muted ?? _snapshot.muted,
      failure: clearFailure ? null : failure ?? _snapshot.failure,
    );
    _snapshot = PlaybackSnapshot(
      sessionId: _snapshot.sessionId,
      revision: ++snapshotRevision,
      status: _snapshot.status,
      currentItem: _snapshot.currentItem,
      position: _snapshot.position,
      duration: _snapshot.duration,
      queueItems: _snapshot.queueItems,
      queueEntries: _snapshot.queueEntries,
      playOrderEntryIds: _snapshot.playOrderEntryIds,
      currentEntryId: _snapshot.currentEntryId,
      currentIndex: _snapshot.currentIndex,
      repeatMode: _snapshot.repeatMode,
      shuffleEnabled: _snapshot.shuffleEnabled,
      volume: _snapshot.volume,
      muted: _snapshot.muted,
      failure: _snapshot.failure,
    );
    _snapshotController.add(_snapshot);
    _log();
  }

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
    } catch (_) {}
  }

  Future<void> dispose() async {
    if (disposedFlag) return;
    disposedFlag = true;
    ++loadGeneration;
    if (_started) await _engineSubscription.cancel();
    await _engine.dispose();
    _snapshot = _makeSnapshot(
      status: PlaybackStatus.disposed,
      position: _snapshot.position,
      duration: _snapshot.duration,
      volume: _snapshot.volume,
      muted: _snapshot.muted,
      failure: _snapshot.failure,
    );
    await _snapshotController.close();
    await _eventController.close();
  }
}
