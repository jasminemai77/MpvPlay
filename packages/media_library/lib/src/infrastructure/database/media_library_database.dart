import 'package:drift/drift.dart';

import 'tables/albums.dart';
import 'tables/artists.dart';
import 'tables/artwork_assets.dart';
import 'tables/favorite_tracks.dart';
import 'tables/genres.dart';
import 'tables/library_roots.dart';
import 'tables/media_files.dart';
import 'tables/scan_runs.dart';
import 'tables/track_artists.dart';
import 'tables/track_genres.dart';
import 'tables/tracks.dart';
import 'tables/user_playlist_items.dart';
import 'tables/user_playlists.dart';
import 'media_library_database.steps.dart';

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
    FavoriteTracks,
    UserPlaylists,
    UserPlaylistItems,
  ],
  include: {'library_search.drift'},
)
final class MediaLibraryDatabase extends _$MediaLibraryDatabase {
  MediaLibraryDatabase(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.favoriteTracks);
        await m.createTable(schema.userPlaylists);
        await m.createTable(schema.userPlaylistItems);
        await m.createIndex(schema.favoriteTracksCreatedAt);
        await m.createIndex(schema.userPlaylistsUpdatedAt);
        await m.createIndex(schema.userPlaylistItemsPlaylistPosition);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}
