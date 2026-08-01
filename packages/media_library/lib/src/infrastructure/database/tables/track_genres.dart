import 'package:drift/drift.dart';

import 'genres.dart';
import 'tracks.dart';

@TableIndex(name: 'track_genres_genre_id', columns: {#genreId})
@TableIndex(name: 'track_genres_track_position', columns: {#trackId, #position})
class TrackGenres extends Table {
  IntColumn get trackId =>
      integer().references(Tracks, #rowId, onDelete: KeyAction.cascade)();
  IntColumn get genreId =>
      integer().references(Genres, #rowId, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {trackId, genreId};

  @override
  List<String> get customConstraints => const ['CHECK (position >= 0)'];
}
