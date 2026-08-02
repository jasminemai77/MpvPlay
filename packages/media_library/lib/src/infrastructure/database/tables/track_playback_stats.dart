import 'package:drift/drift.dart';

import 'tracks.dart';

class TrackPlaybackStats extends Table {
  IntColumn get trackId =>
      integer().references(Tracks, #rowId, onDelete: KeyAction.cascade)();
  IntColumn get playCount => integer()();
  DateTimeColumn get firstPlayedAt => dateTime()();
  DateTimeColumn get lastPlayedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {trackId};

  @override
  List<String> get customConstraints => const [
    'CHECK(play_count >= 0)',
    'CHECK(last_played_at >= first_played_at)',
  ];
}
