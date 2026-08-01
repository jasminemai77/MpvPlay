import 'package:drift/drift.dart';

import 'tracks.dart';

@TableIndex(name: 'favorite_tracks_created_at', columns: {#createdAt, #trackId})
class FavoriteTracks extends Table {
  IntColumn get trackId =>
      integer().references(Tracks, #rowId, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {trackId};
}
