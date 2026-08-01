import 'package:drift/drift.dart';

import 'artists.dart';
import 'tracks.dart';

@TableIndex(
  name: 'track_artists_artist_role_position',
  columns: {#artistId, #role, #position},
)
@TableIndex(
  name: 'track_artists_track_position',
  columns: {#trackId, #position},
)
class TrackArtists extends Table {
  IntColumn get trackId =>
      integer().references(Tracks, #rowId, onDelete: KeyAction.cascade)();
  IntColumn get artistId =>
      integer().references(Artists, #rowId, onDelete: KeyAction.cascade)();
  TextColumn get role => text()();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {trackId, artistId, role};

  @override
  List<String> get customConstraints => const [
    'CHECK (position >= 0)',
    "CHECK (role IN ('primary', 'performer'))",
  ];
}
