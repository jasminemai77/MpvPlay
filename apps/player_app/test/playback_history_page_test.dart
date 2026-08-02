import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_library/media_library.dart';
import 'package:mpv_play/features/history/application/history_providers.dart';
import 'package:mpv_play/features/history/presentation/playback_history_page.dart';

void main() {
  testWidgets('shows an empty history state', (tester) async {
    await tester.pumpWidget(_page(const []));
    expect(find.text('No playback history yet'), findsOneWidget);
    expect(find.byTooltip('Play recent'), findsOneWidget);
  });

  testWidgets('shows play counts, disables missing records, and replays one', (
    tester,
  ) async {
    final available = _track('available', available: true);
    final missing = _track('missing', available: false);
    List<LibraryTrack>? replayed;
    await tester.pumpWidget(
      _page([
        PlaybackHistoryEntry(
          id: 'entry-available',
          track: available,
          startedAt: DateTime.utc(2026, 8, 2),
          playCount: 3,
        ),
        PlaybackHistoryEntry(
          id: 'entry-missing',
          track: missing,
          startedAt: DateTime.utc(2026, 8, 1),
          playCount: 1,
        ),
      ], onPlay: (tracks, _) async => replayed = tracks),
    );
    await tester.pump();
    expect(find.text('3 plays'), findsOneWidget);
    expect(find.textContaining('File unavailable'), findsOneWidget);
    await tester.tap(find.text('Available Track'));
    await tester.pump();
    expect(replayed, [available]);
  });
}

Widget _page(
  List<PlaybackHistoryEntry> entries, {
  Future<void> Function(List<LibraryTrack>, LibraryTrack)? onPlay,
}) => ProviderScope(
  overrides: [
    recentPlaybackHistoryProvider.overrideWith((_) => Stream.value(entries)),
    missingHistoryTrackCountProvider.overrideWith((_) => Stream.value(0)),
  ],
  child: MaterialApp(
    home: PlaybackHistoryPage(onPlay: onPlay ?? (_, _) async {}),
  ),
);

LibraryTrack _track(String id, {required bool available}) => LibraryTrack(
  id: id,
  mediaFileId: 'media-$id',
  title: available ? 'Available Track' : 'Missing Track',
  displayArtist: 'Artist',
  locator: Uri.parse('file:///$id.mp3'),
  available: available,
);
