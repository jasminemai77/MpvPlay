import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mpv_play/features/history/application/playback_history_observer.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:player_core/player_core.dart';

void main() {
  test('records only the first playing snapshot in a playback cycle', () async {
    final snapshots = StreamController<PlaybackSnapshot>.broadcast(sync: true);
    final records = <String>[];
    final observer = AppPlaybackHistoryObserver(
      snapshots: snapshots.stream,
      recordPlaybackStarted:
          ({
            required trackId,
            required playbackSessionId,
            required startedAt,
          }) async {
            records.add(trackId);
          },
    );
    snapshots
      ..add(_snapshot(PlaybackStatus.loading, 'track-1'))
      ..add(_snapshot(PlaybackStatus.ready, 'track-1'))
      ..add(_snapshot(PlaybackStatus.playing, 'track-1'))
      ..add(_snapshot(PlaybackStatus.playing, 'track-1'))
      ..add(_snapshot(PlaybackStatus.paused, 'track-1'))
      ..add(_snapshot(PlaybackStatus.playing, 'track-1'));
    await observer.close();
    expect(records, ['track-1']);
    await snapshots.close();
  });

  test('track changes and terminal states begin new playback cycles', () async {
    final snapshots = StreamController<PlaybackSnapshot>.broadcast(sync: true);
    final records = <String>[];
    final observer = _observer(snapshots, records);
    snapshots
      ..add(_snapshot(PlaybackStatus.playing, 'track-1'))
      ..add(_snapshot(PlaybackStatus.playing, 'track-2'))
      ..add(_snapshot(PlaybackStatus.completed, 'track-2'))
      ..add(_snapshot(PlaybackStatus.playing, 'track-2'))
      ..add(_snapshot(PlaybackStatus.stopped, 'track-2'))
      ..add(_snapshot(PlaybackStatus.playing, 'track-2'));
    await observer.close();
    expect(records, ['track-1', 'track-2', 'track-2', 'track-2']);
    await snapshots.close();
  });

  test(
    'a failed write never interrupts playback observation and can retry',
    () async {
      final snapshots = StreamController<PlaybackSnapshot>.broadcast(
        sync: true,
      );
      var attempts = 0;
      final observer = AppPlaybackHistoryObserver(
        snapshots: snapshots.stream,
        recordPlaybackStarted:
            ({
              required trackId,
              required playbackSessionId,
              required startedAt,
            }) async {
              attempts++;
              if (attempts == 1) throw StateError('database unavailable');
            },
      );
      snapshots.add(_snapshot(PlaybackStatus.playing, 'track-1'));
      await Future<void>.delayed(Duration.zero);
      snapshots.add(_snapshot(PlaybackStatus.playing, 'track-1'));
      await observer.close();
      expect(attempts, 2);
      await snapshots.close();
    },
  );

  test('close waits for the in-flight history write', () async {
    final snapshots = StreamController<PlaybackSnapshot>.broadcast(sync: true);
    final writeCompleter = Completer<void>();
    final observer = AppPlaybackHistoryObserver(
      snapshots: snapshots.stream,
      recordPlaybackStarted:
          ({
            required trackId,
            required playbackSessionId,
            required startedAt,
          }) => writeCompleter.future,
    );
    snapshots.add(_snapshot(PlaybackStatus.playing, 'track-1'));
    await Future<void>.delayed(Duration.zero);
    var closed = false;
    final closing = observer.close().then((_) => closed = true);
    await Future<void>.delayed(Duration.zero);
    expect(closed, isFalse);
    writeCompleter.complete();
    await closing;
    expect(closed, isTrue);
    await snapshots.close();
  });
}

AppPlaybackHistoryObserver _observer(
  StreamController<PlaybackSnapshot> snapshots,
  List<String> records,
) => AppPlaybackHistoryObserver(
  snapshots: snapshots.stream,
  recordPlaybackStarted:
      ({
        required trackId,
        required playbackSessionId,
        required startedAt,
      }) async {
        records.add(trackId);
      },
);

PlaybackSnapshot _snapshot(PlaybackStatus status, String? id) {
  final item = id == null
      ? null
      : PlayableItem(
          id: id,
          title: id,
          source: MediaSource(
            id: id,
            uri: Uri.parse('file:///$id.mp3'),
            kind: MediaKind.audio,
          ),
        );
  return PlaybackSnapshot(
    sessionId: 'runtime-session',
    revision: 1,
    status: status,
    currentItem: item,
    position: Duration.zero,
    duration: Duration.zero,
    queueItems: item == null ? const [] : [item],
    currentIndex: item == null ? -1 : 0,
    volume: 1,
    muted: false,
    failure: null,
  );
}
