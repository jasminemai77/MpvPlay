import 'package:drift/drift.dart';

import 'tracks.dart';
import 'user_playlists.dart';

@TableIndex(
  name: 'user_playlist_items_playlist_position',
  columns: {#playlistId, #position},
)
class UserPlaylistItems extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  IntColumn get playlistId => integer().references(
    UserPlaylists,
    #rowId,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get trackId => integer().references(
    Tracks,
    #rowId,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get position => integer()();
  DateTimeColumn get addedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {playlistId, trackId},
    {playlistId, position},
  ];

  @override
  List<String> get customConstraints => const ['CHECK (position >= 0)'];
}
