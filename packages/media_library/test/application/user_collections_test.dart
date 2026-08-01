import 'package:drift/drift.dart';
import 'package:media_library/media_library.dart';
import 'package:media_library/src/infrastructure/database/database_connection.dart';
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
    'favorites are idempotent, ordered, and preserve missing relations',
    () async {
      await facade.setFavorite(firstTrack, true);
      await facade.setFavorite(firstTrack, true);
      await facade.setFavorite(secondTrack, true);
      expect(await facade.watchFavoriteTracks().first, hasLength(2));
      expect(
        await database.select(database.favoriteTracks).get(),
        hasLength(2),
      );

      final first = await (_trackRow(database, firstTrack));
      await _setAvailability(database, first.mediaFileId, 'missing');
      expect(await facade.watchFavoriteTracks().first, hasLength(1));
      expect(await facade.query.watchMissingFavoriteCount().first, 1);

      await _setAvailability(database, first.mediaFileId, 'available');
      expect(await facade.watchFavoriteTracks().first, hasLength(2));
      await facade.setFavorite(firstTrack, false);
      await facade.setFavorite(firstTrack, false);
      expect(
        await database.select(database.favoriteTracks).get(),
        hasLength(1),
      );
    },
  );

  test('playlist persists mutation, ordering, and cascade semantics', () async {
    final playlist = await facade.createPlaylist(name: '  Favorites  ');
    expect(playlist.name, 'Favorites');
    await facade.addTrackToPlaylist(playlist.id, firstTrack);
    await facade.addTrackToPlaylist(playlist.id, secondTrack);
    final firstRow = await _trackRow(database, firstTrack);
    await _setAvailability(database, firstRow.mediaFileId, 'missing');
    var detail = await facade.watchPlaylist(playlist.id).first;
    expect(detail!.tracks.singleWhere((track) => track.id == firstTrack).available,
        isFalse);
    await _setAvailability(database, firstRow.mediaFileId, 'available');
    await expectLater(
      facade.addTrackToPlaylist(playlist.id, firstTrack),
      throwsA(
        isA<CollectionFailure>().having(
          (failure) => failure.code,
          'code',
          CollectionFailureCode.duplicatePlaylistTrack,
        ),
      ),
    );
    await facade.reorderPlaylistTracks(playlist.id, [secondTrack, firstTrack]);
    detail = await facade.watchPlaylist(playlist.id).first;
    expect(detail!.tracks.map((track) => track.id), [secondTrack, firstTrack]);

    await expectLater(
      facade.reorderPlaylistTracks(playlist.id, [firstTrack]),
      throwsA(
        isA<CollectionFailure>().having(
          (failure) => failure.code,
          'code',
          CollectionFailureCode.invalidTrackOrder,
        ),
      ),
    );
    detail = await facade.watchPlaylist(playlist.id).first;
    expect(detail!.tracks.map((track) => track.id), [secondTrack, firstTrack]);

    await facade.removeTrackFromPlaylist(playlist.id, secondTrack);
    expect(
      (await facade.watchPlaylist(playlist.id).first)!.tracks.single.id,
      firstTrack,
    );
    await facade.deletePlaylist(playlist.id);
    expect(await facade.watchPlaylist(playlist.id).first, isA<Null>());
    expect(await database.select(database.tracks).get(), hasLength(2));
    expect(await database.select(database.userPlaylistItems).get(), isEmpty);
  });

  test(
    'invalid names and unknown tracks yield explicit collection failures',
    () async {
      await expectLater(
        facade.createPlaylist(name: '   '),
        throwsA(isA<CollectionFailure>()),
      );
      await expectLater(
        facade.setFavorite('no-such-track', true),
        throwsA(
          isA<CollectionFailure>().having(
            (failure) => failure.code,
            'code',
            CollectionFailureCode.trackNotFound,
          ),
        ),
      );
    },
  );
}

Future<String> _seedTrack(MediaLibraryDatabase database, int index) async {
  final now = DateTime.now().toUtc();
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
  int mediaFileId,
  String state,
) =>
    (database.update(database.mediaFiles)
          ..where((row) => row.rowId.equals(mediaFileId)))
        .write(MediaFilesCompanion(availabilityState: Value(state)));
