import 'dart:io';

import 'package:drift/drift.dart';
import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  test(
    'v1 to v2 migration preserves library data and creates collection tables',
    () async {
      final directory = await Directory.systemTemp.createTemp('mpvplay-v2-');
      final file = File('${directory.path}${Platform.pathSeparator}library.db');
      final v2 = MediaLibraryDatabase(openMediaLibraryDatabase(file));
      final now = DateTime.now().toUtc();
      final rootId = await v2
          .into(v2.libraryRoots)
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
      final mediaId = await v2
          .into(v2.mediaFiles)
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
      await v2
          .into(v2.tracks)
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
      await v2.customStatement('DROP TABLE user_playlist_items');
      await v2.customStatement('DROP TABLE user_playlists');
      await v2.customStatement('DROP TABLE favorite_tracks');
      await v2.customStatement('PRAGMA user_version = 1');
      await v2.close();

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
      expect(migrated.schemaVersion, 2);
      await migrated
          .into(migrated.favoriteTracks)
          .insert(
            FavoriteTracksCompanion.insert(
              trackId: const Value(1),
              createdAt: DateTime.now().toUtc(),
            ),
          );
      expect(
        await migrated.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
    },
  );
}
