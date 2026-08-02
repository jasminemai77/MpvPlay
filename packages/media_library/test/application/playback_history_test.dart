import 'package:drift/drift.dart' hide isNull;
import 'package:media_library/media_library.dart';
import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/dao/playback_history_dao.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  late MediaLibraryDatabase database;
  late MediaLibraryFacade facade;
  late String firstTrack;
  late String secondTrack;

  setUp(() async {
    database = MediaLibraryDatabase(openInMemoryMediaLibraryDatabase());
    facade = MediaLibraryFacade(database);
    firstTrack = await _seedTrack(database, 1);
    secondTrack = await _seedTrack(database, 2);
  });
  tearDown(() => database.close());

  test(
    'records ordered events and cumulative independent play counts',
    () async {
      final first = DateTime.utc(2026, 8, 2, 10);
      await facade.recordPlaybackStarted(
        trackId: firstTrack,
        playbackSessionId: 'first-session',
        startedAt: first,
      );
      await facade.recordPlaybackStarted(
        trackId: firstTrack,
        playbackSessionId: 'second-session',
        startedAt: first.add(const Duration(minutes: 1)),
      );
      await facade.recordPlaybackStarted(
        trackId: secondTrack,
        playbackSessionId: 'third-session',
        startedAt: first.add(const Duration(minutes: 2)),
      );

      final history = await facade.watchRecentPlaybackHistory().first;
      expect(history.map((entry) => entry.track.id), [
        secondTrack,
        firstTrack,
        firstTrack,
      ]);
      expect(history.first.playCount, 1);
      expect(history[1].playCount, 2);
      final firstStats = await facade.watchTrackPlaybackStats(firstTrack).first;
      expect(firstStats!.playCount, 2);
      expect(firstStats.firstPlayedAt.toUtc(), first);
      expect(
        firstStats.lastPlayedAt.toUtc(),
        first.add(const Duration(minutes: 1)),
      );
    },
  );

  test('duplicate playback session is idempotent', () async {
    final startedAt = DateTime.utc(2026, 8, 2, 10);
    await facade.recordPlaybackStarted(
      trackId: firstTrack,
      playbackSessionId: 'same-session',
      startedAt: startedAt,
    );
    await facade.recordPlaybackStarted(
      trackId: firstTrack,
      playbackSessionId: 'same-session',
      startedAt: startedAt.add(const Duration(hours: 1)),
    );
    expect(await facade.watchRecentPlaybackHistory().first, hasLength(1));
    final stats = await facade.watchTrackPlaybackStats(firstTrack).first;
    expect(stats!.playCount, 1);
    expect(stats.lastPlayedAt.toUtc(), startedAt);
  });

  test(
    'missing tracks retain history and become playable after recovery',
    () async {
      await facade.recordPlaybackStarted(
        trackId: firstTrack,
        playbackSessionId: 'missing-session',
        startedAt: DateTime.utc(2026, 8, 2, 10),
      );
      await _setAvailability(database, firstTrack, 'missing');
      final history = await facade.watchRecentPlaybackHistory().first;
      expect(history.single.track.available, isFalse);
      expect(await facade.watchMissingHistoryTrackCount().first, 1);
      await _setAvailability(database, firstTrack, 'available');
      expect(
        (await facade.watchRecentPlaybackHistory().first)
            .single
            .track
            .available,
        isTrue,
      );
    },
  );

  test(
    'retention removes old events without reducing cumulative statistics',
    () async {
      final startedAt = DateTime.utc(2026, 8, 1);
      final track = await _trackRow(database, firstTrack);
      await database
          .into(database.trackPlaybackStats)
          .insert(
            TrackPlaybackStatsCompanion.insert(
              trackId: Value(track.rowId),
              playCount: PlaybackHistoryDao.maxRetainedEntries,
              firstPlayedAt: startedAt,
              lastPlayedAt: startedAt,
            ),
          );
      await database.batch((batch) {
        batch.insertAll(
          database.playbackHistoryEntries,
          List.generate(
            PlaybackHistoryDao.maxRetainedEntries,
            (index) => PlaybackHistoryEntriesCompanion.insert(
              publicId: 'old-$index',
              playbackSessionId: 'old-session-$index',
              trackId: track.rowId,
              startedAt: startedAt.add(Duration(seconds: index)),
            ),
          ),
        );
      });
      await facade.recordPlaybackStarted(
        trackId: firstTrack,
        playbackSessionId: 'new-session',
        startedAt: startedAt.add(const Duration(days: 1)),
      );
      expect(
        await database.select(database.playbackHistoryEntries).get(),
        hasLength(PlaybackHistoryDao.maxRetainedEntries),
      );
      expect(
        (await facade.watchTrackPlaybackStats(firstTrack).first)!.playCount,
        PlaybackHistoryDao.maxRetainedEntries + 1,
      );
    },
  );

  test('clear history atomically resets events and statistics', () async {
    await facade.recordPlaybackStarted(
      trackId: firstTrack,
      playbackSessionId: 'clear-session',
      startedAt: DateTime.utc(2026, 8, 2),
    );
    await facade.clearPlaybackHistory();
    expect(await facade.watchRecentPlaybackHistory().first, isEmpty);
    expect(await facade.watchTrackPlaybackStats(firstTrack).first, isNull);
    expect(
      await database.select(database.playbackHistoryEntries).get(),
      isEmpty,
    );
    expect(await database.select(database.trackPlaybackStats).get(), isEmpty);
  });

  test(
    'invalid IDs use explicit history failures and physical deletes cascade',
    () async {
      await expectLater(
        facade.recordPlaybackStarted(
          trackId: firstTrack,
          playbackSessionId: '   ',
          startedAt: DateTime.utc(2026, 8, 2),
        ),
        throwsA(
          isA<PlaybackHistoryFailure>().having(
            (failure) => failure.code,
            'code',
            PlaybackHistoryFailureCode.invalidPlaybackSessionId,
          ),
        ),
      );
      await expectLater(
        facade.recordPlaybackStarted(
          trackId: 'unknown',
          playbackSessionId: 'unknown-session',
          startedAt: DateTime.utc(2026, 8, 2),
        ),
        throwsA(
          isA<PlaybackHistoryFailure>().having(
            (failure) => failure.code,
            'code',
            PlaybackHistoryFailureCode.trackNotFound,
          ),
        ),
      );
      await facade.recordPlaybackStarted(
        trackId: firstTrack,
        playbackSessionId: 'delete-session',
        startedAt: DateTime.utc(2026, 8, 2),
      );
      final track = await _trackRow(database, firstTrack);
      await (database.delete(
        database.tracks,
      )..where((row) => row.rowId.equals(track.rowId))).go();
      expect(
        await database.select(database.playbackHistoryEntries).get(),
        isEmpty,
      );
      expect(await database.select(database.trackPlaybackStats).get(), isEmpty);
      expect(
        await database.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
    },
  );
}

Future<String> _seedTrack(MediaLibraryDatabase database, int index) async {
  final now = DateTime.utc(2026, 8, 2);
  final rootId = await database
      .into(database.libraryRoots)
      .insert(
        LibraryRootsCompanion.insert(
          publicId: 'root-$index',
          sourceType: 'windowsDirectory',
          locator: 'C:\\music-$index',
          locatorKey: 'c:\\music-$index',
          displayName: 'Music $index',
          createdAt: now,
          updatedAt: now,
        ),
      );
  final mediaId = await database
      .into(database.mediaFiles)
      .insert(
        MediaFilesCompanion.insert(
          publicId: 'media-$index',
          rootId: rootId,
          locator: 'C:\\music-$index\\song-$index.mp3',
          locatorKey: 'c:\\music-$index\\song-$index.mp3',
          relativePath: 'song-$index.mp3',
          fileName: 'song-$index.mp3',
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
  final publicId = 'track-$index';
  await database
      .into(database.tracks)
      .insert(
        TracksCompanion.insert(
          publicId: publicId,
          mediaFileId: mediaId,
          title: 'Song $index',
          sortTitle: 'song $index',
          searchText: 'song $index',
          createdAt: now,
          updatedAt: now,
        ),
      );
  return publicId;
}

Future<Track> _trackRow(MediaLibraryDatabase database, String publicId) =>
    (database.select(
      database.tracks,
    )..where((row) => row.publicId.equals(publicId))).getSingle();

Future<void> _setAvailability(
  MediaLibraryDatabase database,
  String publicId,
  String state,
) async {
  final track = await _trackRow(database, publicId);
  await (database.update(database.mediaFiles)
        ..where((row) => row.rowId.equals(track.mediaFileId)))
      .write(MediaFilesCompanion(availabilityState: Value(state)));
}
