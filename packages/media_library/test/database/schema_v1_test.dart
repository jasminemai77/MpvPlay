import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  test(
    'schema v3 contains collection, history, constraints, foreign keys and FTS',
    () async {
      final database = MediaLibraryDatabase(openInMemoryMediaLibraryDatabase());
      addTearDown(database.close);

      expect(database.schemaVersion, 3);
      final tables = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type IN ('table', 'view') ORDER BY name",
          )
          .get();
      final tableNames = tables.map((row) => row.read<String>('name')).toSet();
      expect(
        tableNames,
        containsAll({
          'library_roots',
          'scan_runs',
          'media_files',
          'artwork_assets',
          'artists',
          'albums',
          'tracks',
          'track_artists',
          'genres',
          'track_genres',
          'favorite_tracks',
          'user_playlists',
          'user_playlist_items',
          'playback_history_entries',
          'track_playback_stats',
          'track_search_fts',
        }),
      );

      final indexes = await database
          .customSelect("SELECT name FROM sqlite_master WHERE type = 'index'")
          .get();
      final indexNames = indexes.map((row) => row.read<String>('name')).toSet();
      expect(
        indexNames,
        containsAll({
          'media_files_root_availability',
          'media_files_root_last_seen_generation',
          'media_files_platform_file_id',
          'media_files_quick_fingerprint',
          'media_files_content_hash',
          'artists_sort_name',
          'artists_name',
          'albums_sort_title',
          'albums_album_artist_id',
          'albums_artwork_id',
          'tracks_album_id',
          'tracks_sort_title',
          'tracks_title',
          'tracks_artwork_id',
          'track_artists_artist_role_position',
          'track_artists_track_position',
          'track_genres_genre_id',
          'track_genres_track_position',
          'favorite_tracks_created_at',
          'user_playlists_updated_at',
          'user_playlist_items_playlist_position',
          'playback_history_entries_started_at',
          'playback_history_entries_track_started_at',
        }),
      );

      for (final table in const [
        'scan_runs',
        'media_files',
        'albums',
        'tracks',
        'track_artists',
        'track_genres',
        'favorite_tracks',
        'user_playlist_items',
        'playback_history_entries',
        'track_playback_stats',
      ]) {
        final foreignKeys = await database
            .customSelect('PRAGMA foreign_key_list($table)')
            .get();
        expect(
          foreignKeys,
          isNotEmpty,
          reason: '$table must have foreign keys',
        );
      }
      final foreignKeys = await database
          .customSelect('PRAGMA foreign_keys')
          .getSingle();
      expect(foreignKeys.read<int>('foreign_keys'), 1);
      expect(
        await database.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
    },
  );
}
