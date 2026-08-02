import 'dart:io';

import 'package:drift/drift.dart';
import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  test('v2 to v3 migration preserves library and collection data', () async {
    final directory = await Directory.systemTemp.createTemp('mpvplay-v2-');
    final file = File('${directory.path}${Platform.pathSeparator}library.db');
    final current = MediaLibraryDatabase(openMediaLibraryDatabase(file));
    final now = DateTime.now().toUtc();
    final rootId = await current
        .into(current.libraryRoots)
        .insert(
          LibraryRootsCompanion.insert(
            publicId: 'root-v1',
            sourceType: 'windowsDirectory',
            locator: 'C:\\music',
            locatorKey: 'c:\\music',
            displayName: 'Music',
            createdAt: now,
            updatedAt: now,
          ),
        );
    final mediaId = await current
        .into(current.mediaFiles)
        .insert(
          MediaFilesCompanion.insert(
            publicId: 'media-v1',
            rootId: rootId,
            locator: 'C:\\music\\song.mp3',
            locatorKey: 'c:\\music\\song.mp3',
            relativePath: 'song.mp3',
            fileName: 'song.mp3',
            extension: 'mp3',
            sizeBytes: 1,
            modifiedAtMicros: now.microsecondsSinceEpoch,
            availabilityState: 'available',
            metadataState: 'ready',
            lastSeenGeneration: 1,
            lastSeenAt: now,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await current
        .into(current.tracks)
        .insert(
          TracksCompanion.insert(
            publicId: 'track-v1',
            mediaFileId: mediaId,
            title: 'Migrated Song',
            sortTitle: 'migrated song',
            searchText: 'migrated song',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await current
        .into(current.favoriteTracks)
        .insert(
          FavoriteTracksCompanion.insert(
            trackId: const Value(1),
            createdAt: now,
          ),
        );
    final playlistId = await current
        .into(current.userPlaylists)
        .insert(
          UserPlaylistsCompanion.insert(
            publicId: 'playlist-v2',
            name: 'Migrated playlist',
            normalizedName: 'migrated playlist',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await current
        .into(current.userPlaylistItems)
        .insert(
          UserPlaylistItemsCompanion.insert(
            playlistId: playlistId,
            trackId: 1,
            position: 0,
            addedAt: now,
          ),
        );
    await current.customStatement('DROP TABLE playback_history_entries');
    await current.customStatement('DROP TABLE track_playback_stats');
    await current.customStatement('PRAGMA user_version = 2');
    await current.close();

    final migrated = MediaLibraryDatabase(openMediaLibraryDatabase(file));
    addTearDown(() async {
      await migrated.close();
      await directory.delete(recursive: true);
    });
    expect(await migrated.select(migrated.tracks).get(), hasLength(1));
    expect(
      (await migrated.select(migrated.tracks).getSingle()).publicId,
      'track-v1',
    );
    expect(migrated.schemaVersion, 3);
    expect(await migrated.select(migrated.favoriteTracks).get(), hasLength(1));
    expect(await migrated.select(migrated.userPlaylists).get(), hasLength(1));
    expect(
      await migrated.select(migrated.userPlaylistItems).get(),
      hasLength(1),
    );
    await migrated
        .into(migrated.trackPlaybackStats)
        .insert(
          TrackPlaybackStatsCompanion.insert(
            trackId: const Value(1),
            playCount: 1,
            firstPlayedAt: now,
            lastPlayedAt: now,
          ),
        );
    await migrated
        .into(migrated.playbackHistoryEntries)
        .insert(
          PlaybackHistoryEntriesCompanion.insert(
            publicId: 'history-v3',
            playbackSessionId: 'session-v3',
            trackId: 1,
            startedAt: now,
          ),
        );
    expect(
      await migrated.customSelect('PRAGMA foreign_key_check').get(),
      isEmpty,
    );
  });
}
