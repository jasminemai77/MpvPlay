import 'package:drift/drift.dart';

import 'albums.dart';
import 'artwork_assets.dart';
import 'media_files.dart';

@TableIndex(name: 'tracks_album_id', columns: {#albumId})
@TableIndex(name: 'tracks_sort_title', columns: {#sortTitle})
@TableIndex(name: 'tracks_title', columns: {#title})
@TableIndex(name: 'tracks_artwork_id', columns: {#artworkId})
class Tracks extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  IntColumn get mediaFileId => integer().unique().references(
    MediaFiles,
    #rowId,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get title => text()();
  TextColumn get sortTitle => text()();
  TextColumn get displayArtist => text().nullable()();
  TextColumn get displayAlbum => text().nullable()();
  IntColumn get albumId => integer().nullable().references(
    Albums,
    #rowId,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get durationMs => integer().nullable()();
  IntColumn get bitrateBps => integer().nullable()();
  IntColumn get sampleRateHz => integer().nullable()();
  IntColumn get trackNumber => integer().nullable()();
  IntColumn get trackTotal => integer().nullable()();
  IntColumn get discNumber => integer().nullable()();
  IntColumn get discTotal => integer().nullable()();
  IntColumn get releaseYear => integer().nullable()();
  TextColumn get language => text().nullable()();
  TextColumn get metadataSource => text().nullable()();
  IntColumn get metadataRevision => integer().withDefault(const Constant(0))();
  TextColumn get searchText => text()();
  IntColumn get artworkId => integer().nullable().references(
    ArtworkAssets,
    #rowId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<String> get customConstraints => const [
    'CHECK (duration_ms IS NULL OR duration_ms >= 0)',
    'CHECK (bitrate_bps IS NULL OR bitrate_bps >= 0)',
    'CHECK (sample_rate_hz IS NULL OR sample_rate_hz > 0)',
    'CHECK (track_number IS NULL OR track_number > 0)',
    'CHECK (track_total IS NULL OR track_total > 0)',
    'CHECK (disc_number IS NULL OR disc_number > 0)',
    'CHECK (disc_total IS NULL OR disc_total > 0)',
    'CHECK (release_year IS NULL OR release_year BETWEEN 1 AND 9999)',
    'CHECK (metadata_revision >= 0)',
  ];
}
