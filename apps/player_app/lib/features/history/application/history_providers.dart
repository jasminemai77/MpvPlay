import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../../library/application/library_providers.dart';

final recentPlaybackHistoryProvider =
    StreamProvider<List<PlaybackHistoryEntry>>(
      (ref) => ref.watch(libraryFacadeProvider).watchRecentPlaybackHistory(),
    );
final missingHistoryTrackCountProvider = StreamProvider<int>(
  (ref) => ref.watch(libraryFacadeProvider).watchMissingHistoryTrackCount(),
);
final playbackHistoryControllerProvider = Provider<PlaybackHistoryController>(
  (ref) => PlaybackHistoryController(ref.watch(libraryFacadeProvider)),
);

final class PlaybackHistoryController {
  PlaybackHistoryController(this._library);
  final MediaLibraryFacade _library;

  Future<void> clearHistory() => _library.clearPlaybackHistory();
}
