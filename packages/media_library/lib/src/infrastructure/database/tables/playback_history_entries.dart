import 'package:drift/drift.dart';

import 'tracks.dart';

@TableIndex(name: 'playback_history_entries_started_at', columns: {#startedAt})
@TableIndex(
  name: 'playback_history_entries_track_started_at',
  columns: {#trackId, #startedAt},
)
class PlaybackHistoryEntries extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  TextColumn get playbackSessionId => text().unique()();
  IntColumn get trackId =>
      integer().references(Tracks, #rowId, onDelete: KeyAction.cascade)();
  DateTimeColumn get startedAt => dateTime()();
}
