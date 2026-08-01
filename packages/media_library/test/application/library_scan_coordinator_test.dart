import 'dart:io';

import 'package:media_library/media_library.dart';
import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:media_library/src/infrastructure/filesystem/directory_enumerator.dart';
import 'package:media_library/src/infrastructure/filesystem/file_identity_provider.dart';
import 'package:media_library/src/infrastructure/metadata/basic_metadata_reader.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  late MediaLibraryDatabase database;
  late MediaLibraryFacade facade;
  late LibraryScanCoordinator coordinator;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('mpvplay-scan-');
    database = MediaLibraryDatabase(openInMemoryMediaLibraryDatabase());
    facade = MediaLibraryFacade(database);
    coordinator = LibraryScanCoordinator(database);
    await facade.addDirectoryRoot(
      locator: directory.path,
      displayName: 'Fixture root',
    );
  });

  tearDown(() async {
    await coordinator.close();
    await facade.close();
    await directory.delete(recursive: true);
  });

  test(
    'scan inserts files, applies filename fallback, and finalizes missing only after success',
    () async {
      final audio = File(
        '${directory.path}${Platform.pathSeparator}01 - 七里香.flac',
      );
      await audio.writeAsBytes([1, 2, 3]);
      final root = (await facade.query.listRoots()).single;
      await coordinator.scanAndWait(root.id);
      final tracks = await facade.query.listTracks();
      expect(tracks.single.title, '七里香');
      expect(tracks.single.available, isTrue);
      expect(
        (await facade.query.searchTracks('七里香')).single.id,
        tracks.single.id,
      );

      await audio.delete();
      await coordinator.scanAndWait(root.id);
      final file = await database.select(database.mediaFiles).getSingle();
      expect(file.availabilityState, 'missing');
    },
  );

  test('a cancelled scan never runs missing finalization', () async {
    final audio = File('${directory.path}${Platform.pathSeparator}song.mp3');
    await audio.writeAsBytes([1]);
    final root = (await facade.query.listRoots()).single;
    await coordinator.scanAndWait(root.id);
    await audio.delete();
    final cancellation = ScanCancellationToken()..cancel();
    await coordinator.scanAndWait(root.id, token: cancellation);
    final file = await database.select(database.mediaFiles).getSingle();
    expect(file.availabilityState, 'available');
  });

  test(
    'an unavailable root never finalizes existing files as missing',
    () async {
      final audio = File('${directory.path}${Platform.pathSeparator}song.mp3');
      await audio.writeAsBytes([1]);
      final root = (await facade.query.listRoots()).single;
      await coordinator.scanAndWait(root.id);
      await directory.delete(recursive: true);
      await coordinator.scanAndWait(root.id);
      final file = await database.select(database.mediaFiles).getSingle();
      expect(file.availabilityState, 'available');
      directory = await Directory.systemTemp.createTemp(
        'mpvplay-scan-replacement-',
      );
    },
  );

  test('overlapping directory roots are rejected before persistence', () async {
    final nested = await Directory(
      '${directory.path}${Platform.pathSeparator}nested',
    ).create();
    await expectLater(
      facade.addDirectoryRoot(locator: nested.path, displayName: 'Nested root'),
      throwsA(isA<LibraryRootOverlapException>()),
    );
  });

  test(
    'unique platform File ID preserves media and track identity after rename',
    () async {
      final source = File(
        '${directory.path}${Platform.pathSeparator}before.mp3',
      );
      await source.writeAsBytes([1]);
      final scan = LibraryScanCoordinator(
        database,
        enumerator: DirectoryEnumerator(
          identityProvider: _StableIdentityProvider(),
        ),
      );
      addTearDown(scan.close);
      final root = (await facade.query.listRoots()).single;
      await scan.scanAndWait(root.id);
      final firstFile = await database.select(database.mediaFiles).getSingle();
      final firstTrack = await database.select(database.tracks).getSingle();
      await source.rename(
        '${directory.path}${Platform.pathSeparator}after.mp3',
      );
      await scan.scanAndWait(root.id);
      final secondFile = await database.select(database.mediaFiles).getSingle();
      final secondTrack = await database.select(database.tracks).getSingle();
      expect(secondFile.publicId, firstFile.publicId);
      expect(secondTrack.publicId, firstTrack.publicId);
      expect(secondFile.fileName, 'after.mp3');
    },
  );

  test(
    'metadata creates stable album, artist, and genre relationships',
    () async {
      final source = File(
        '${directory.path}${Platform.pathSeparator}tagged.mp3',
      );
      await source.writeAsBytes([1]);
      final scan = LibraryScanCoordinator(
        database,
        enumerator: DirectoryEnumerator(
          identityProvider: _StableIdentityProvider(),
        ),
        metadataReader: _TaggedMetadataReader(),
      );
      addTearDown(scan.close);
      final root = (await facade.query.listRoots()).single;
      await scan.scanAndWait(root.id);
      final album = (await facade.query.watchAlbums().first).single;
      final artist = (await facade.query.watchArtists().first).single;
      expect(
        (await facade.query.tracksForAlbum(album.id)).single.title,
        'Tagged Song',
      );
      expect(
        (await facade.query.tracksForArtist(artist.id)).single.title,
        'Tagged Song',
      );
      expect(await database.select(database.trackGenres).get(), hasLength(1));
    },
  );
}

final class _StableIdentityProvider implements FileIdentityProvider {
  @override
  Future<String?> getPlatformFileId(Uri locator) async => 'windows:test:stable';
}

final class _TaggedMetadataReader implements TrackMetadataReader {
  @override
  Future<MetadataReadResult> read(EnumeratedAudioFile file) async =>
      const MetadataReadResult.success(
        BasicTrackMetadata(
          title: 'Tagged Song',
          sortTitle: 'tagged song',
          searchText: 'tagged song tagged artist tagged album',
          source: 'test',
          artist: 'Tagged Artist',
          artists: ['Tagged Artist'],
          album: 'Tagged Album',
          genres: ['Tagged Genre'],
          trackNumber: 1,
        ),
      );
}
