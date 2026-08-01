import 'package:drift/drift.dart';

import 'tables/albums.dart';
import 'tables/artists.dart';
import 'tables/artwork_assets.dart';
import 'tables/genres.dart';
import 'tables/library_roots.dart';
import 'tables/media_files.dart';
import 'tables/scan_runs.dart';
import 'tables/track_artists.dart';
import 'tables/track_genres.dart';
import 'tables/tracks.dart';

part 'media_library_database.g.dart';

@DriftDatabase(
  tables: [
    LibraryRoots,
    ScanRuns,
    MediaFiles,
    ArtworkAssets,
    Artists,
    Albums,
    Tracks,
    TrackArtists,
    Genres,
    TrackGenres,
  ],
  include: {'library_search.drift'},
)
final class MediaLibraryDatabase extends _$MediaLibraryDatabase {
  MediaLibraryDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}
