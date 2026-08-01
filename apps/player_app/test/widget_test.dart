import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mpv_play/app/mpv_play_app.dart';
import 'package:mpv_play/features/library/application/library_providers.dart';
import 'package:mpv_play/features/now_playing/application/playback_providers.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';

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
          initialSnapshotProvider.overrideWithValue(snapshot),
          libraryRootsProvider.overrideWith((_) => Stream.value(const [])),
          libraryTracksProvider.overrideWith((_) => Stream.value(const [])),
          libraryScanProgressProvider.overrideWith((_) => const Stream.empty()),
        ],
        child: const MpvPlayApp(),
      ),
    );
    expect(find.text('MpvPlay'), findsOneWidget);
    expect(find.text('Choose music'), findsOneWidget);
    expect(find.text('Queue is empty'), findsOneWidget);
    await client.dispose();
  });
}
