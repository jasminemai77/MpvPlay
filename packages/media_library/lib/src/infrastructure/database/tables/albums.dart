import 'package:drift/drift.dart';

import 'artists.dart';
import 'artwork_assets.dart';

@TableIndex(name: 'albums_sort_title', columns: {#sortTitle})
@TableIndex(name: 'albums_album_artist_id', columns: {#albumArtistId})
@TableIndex(name: 'albums_artwork_id', columns: {#artworkId})
class Albums extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  TextColumn get title => text()();
  TextColumn get sortTitle => text()();
  TextColumn get identityKey => text().unique()();
  IntColumn get albumArtistId => integer().nullable().references(
    Artists,
    #rowId,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get releaseYear => integer().nullable()();
  IntColumn get artworkId => integer().nullable().references(
    ArtworkAssets,
    #rowId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<String> get customConstraints => const [
    'CHECK (release_year IS NULL OR release_year BETWEEN 1 AND 9999)',
  ];
}
