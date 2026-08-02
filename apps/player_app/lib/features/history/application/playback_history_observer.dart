import 'dart:async';
import 'dart:developer' as developer;

import 'package:media_library/media_library.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:uuid/uuid.dart';

/// Observes playback without owning any playback state or issuing commands.
final class AppPlaybackHistoryObserver {
  AppPlaybackHistoryObserver({
    required Stream<PlaybackSnapshot> snapshots,
    required this._recordPlaybackStarted,
  }) {
    _subscription = snapshots.listen(_onSnapshot);
  }

  factory AppPlaybackHistoryObserver.forLibrary({
    required Stream<PlaybackSnapshot> snapshots,
    required MediaLibraryFacade library,
  }) => AppPlaybackHistoryObserver(
    snapshots: snapshots,
    recordPlaybackStarted: library.recordPlaybackStarted,
  );

  static const _uuid = Uuid();
  final Future<void> Function({
    required String trackId,
    required String playbackSessionId,
    required DateTime startedAt,
  })
  _recordPlaybackStarted;
  late final StreamSubscription<PlaybackSnapshot> _subscription;

  Future<void> _pending = Future.value();
  String? _activeTrackId;
  _RecordState _recordState = _RecordState.notRecorded;
  bool _closed = false;

  void _onSnapshot(PlaybackSnapshot snapshot) {
    if (_closed) return;
    final trackId = snapshot.currentItem?.id;
    if (trackId != _activeTrackId) {
      _activeTrackId = trackId;
      _recordState = _RecordState.notRecorded;
    }
    if (_endsCycle(snapshot.status)) {
      _activeTrackId = null;
      _recordState = _RecordState.notRecorded;
      return;
    }
    if (trackId != null &&
        snapshot.status == PlaybackStatus.playing &&
        _recordState == _RecordState.notRecorded) {
      _recordState = _RecordState.pending;
      final sessionId = _uuid.v7();
      _pending = _pending.then((_) async {
        try {
          await _recordPlaybackStarted(
            trackId: trackId,
            playbackSessionId: sessionId,
            startedAt: DateTime.now().toUtc(),
          );
          if (_activeTrackId == trackId) _recordState = _RecordState.recorded;
        } catch (error, stackTrace) {
          developer.log(
            'Unable to persist playback history event',
            name: 'MpvPlay.PlaybackHistoryObserver',
            error: error,
            stackTrace: stackTrace,
          );
          if (_activeTrackId == trackId) {
            _recordState = _RecordState.notRecorded;
          }
        }
      });
    }
  }

  bool _endsCycle(PlaybackStatus status) => switch (status) {
    PlaybackStatus.stopped ||
    PlaybackStatus.completed ||
    PlaybackStatus.failed ||
    PlaybackStatus.disposed => true,
    _ => false,
  };

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await _subscription.cancel();
    await _pending;
  }
}

enum _RecordState { notRecorded, pending, recorded }
