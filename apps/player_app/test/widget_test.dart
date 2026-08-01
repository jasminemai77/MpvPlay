import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mpv_play/main.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class TestClient implements PlaybackClient {
  final controller = StreamController<PlaybackSnapshot>.broadcast();
  @override
  Stream<PlaybackSnapshot> get snapshots => controller.stream;
  @override
  Stream<PlaybackEvent> get events => const Stream.empty();
  @override
  Future<void> send(PlaybackCommand command) async {}
  @override
  Future<void> dispose() => controller.close();
}

void main() {
  testWidgets('renders empty player shell', (tester) async {
    final client = TestClient();
    final snapshot = PlaybackSnapshot(
      sessionId: 'test',
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
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clientProvider.overrideWithValue(client),
          initialProvider.overrideWithValue(snapshot),
        ],
        child: const MpvPlayApp(),
      ),
    );
    expect(find.text('MpvPlay'), findsOneWidget);
    expect(find.text('选择音乐'), findsOneWidget);
    expect(find.text('队列为空'), findsOneWidget);
    await client.dispose();
  });
}
