import 'dart:io';

import 'package:playback_protocol/playback_protocol.dart';
import 'package:platform_bridge/platform_bridge.dart';
import 'package:player_core/player_core.dart';
import 'package:test/test.dart';

PlayableItem _item(File file) => PlayableItem(
  id: file.uri.toString(),
  title: file.uri.pathSegments.last,
  source: MediaSource(
    id: file.uri.toString(),
    uri: file.uri,
    kind: MediaKind.audio,
  ),
);

PlaybackSnapshot _snapshot(List<PlayableItem> items) => PlaybackSnapshot(
  sessionId: 'test',
  revision: 1,
  status: PlaybackStatus.paused,
  currentItem: items[1],
  position: const Duration(seconds: 14),
  duration: const Duration(minutes: 3),
  queueItems: items,
  currentIndex: 1,
  volume: .4,
  muted: true,
  failure: null,
);

void main() {
  test('persists valid files and skips files removed before restore', () async {
    final directory = await Directory.systemTemp.createTemp(
      'mpv-play-session-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final removed = File(
      '${directory.path}${Platform.pathSeparator}removed.mp3',
    );
    final retained = File(
      '${directory.path}${Platform.pathSeparator}retained.mp3',
    );
    await removed.writeAsBytes(const []);
    await retained.writeAsBytes(const []);
    final store = JsonSessionStore(
      File('${directory.path}${Platform.pathSeparator}session.json'),
    );
    await store.save(_snapshot([_item(removed), _item(retained)]));
    await removed.delete();

    final restored = await store.restore();
    expect(restored, isNotNull);
    expect(restored!.items, [_item(retained)]);
    expect(restored.currentIndex, 0);
    expect(restored.position, const Duration(seconds: 14));
    expect(restored.volume, .4);
    expect(restored.muted, isTrue);
    expect(restored.skippedItems, 1);
  });
}
