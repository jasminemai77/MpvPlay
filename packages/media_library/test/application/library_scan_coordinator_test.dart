import 'dart:async';
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
    'a later scan cannot overtake an active generation for the same root',
    () async {
      final paused = _PausedEnumerator();
      final scan = LibraryScanCoordinator(database, enumerator: paused);
      addTearDown(scan.close);
      final root = (await facade.query.listRoots()).single;
      final first = scan.scanAndWait(root.id);
      await paused.started.future;
      await expectLater(scan.scanAndWait(root.id), throwsStateError);
      paused.release.complete();
      await first;
      expect((await facade.query.listRoots()).single.scanGeneration, 1);
    },
  );

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

  test(
    'an enumeration failure never finalizes existing files as missing',
    () async {
      final audio = File('${directory.path}${Platform.pathSeparator}song.mp3');
      await audio.writeAsBytes([1]);
      final root = (await facade.query.listRoots()).single;
      await coordinator.scanAndWait(root.id);
      final failing = LibraryScanCoordinator(
        database,
        enumerator: const _FailingEnumerator(),
      );
      addTearDown(failing.close);
      await failing.scanAndWait(root.id);
      final file = await database.select(database.mediaFiles).getSingle();
      expect(file.availabilityState, 'available');
    },
  );

  test(
    'a database finalization failure never marks existing files missing',
    () async {
      final audio = File('${directory.path}${Platform.pathSeparator}song.mp3');
      await audio.writeAsBytes([1]);
      final root = (await facade.query.listRoots()).single;
      await coordinator.scanAndWait(root.id);
      await audio.delete();
      await database.customStatement('''
      CREATE TRIGGER reject_missing BEFORE UPDATE ON media_files
      WHEN NEW.availability_state = 'missing'
      BEGIN SELECT RAISE(ABORT, 'missing finalization rejected'); END;
    ''');
      await coordinator.scanAndWait(root.id);
      final file = await database.select(database.mediaFiles).getSingle();
      expect(file.availabilityState, 'available');
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
    'repeated File IDs in one scan are not merged as hard-link candidates',
    () async {
      final first = File('${directory.path}${Platform.pathSeparator}one.mp3');
      final second = File('${directory.path}${Platform.pathSeparator}two.mp3');
      await first.writeAsBytes([1]);
      await second.writeAsBytes([1]);
      final stat = await first.stat();
      final scan = LibraryScanCoordinator(
        database,
        enumerator: _FixedEnumerator([
          _entry(first, stat, 'windows:test:hard-link'),
          _entry(second, stat, 'windows:test:hard-link'),
        ]),
      );
      addTearDown(scan.close);
      final root = (await facade.query.listRoots()).single;
      await scan.scanAndWait(root.id);
      expect(await database.select(database.mediaFiles).get(), hasLength(2));
      expect(await database.select(database.tracks).get(), hasLength(2));
    },
  );

  test('a File ID provider failure still creates a playable track', () async {
    final source = File('${directory.path}${Platform.pathSeparator}song.mp3');
    await source.writeAsBytes([1]);
    final scan = LibraryScanCoordinator(
      database,
      enumerator: DirectoryEnumerator(
        identityProvider: _NullIdentityProvider(),
      ),
    );
    addTearDown(scan.close);
    final root = (await facade.query.listRoots()).single;
    await scan.scanAndWait(root.id);
    final track = (await facade.query.listTracks()).single;
    expect(track.available, isTrue);
  });

  test(
    'a unique quick fingerprint restores identity when File ID is absent',
    () async {
      final before = File(
        '${directory.path}${Platform.pathSeparator}before.mp3',
      );
      await before.writeAsBytes([1, 2, 3]);
      final scan = LibraryScanCoordinator(
        database,
        enumerator: DirectoryEnumerator(
          identityProvider: _NullIdentityProvider(),
        ),
      );
      addTearDown(scan.close);
      final root = (await facade.query.listRoots()).single;
      await scan.scanAndWait(root.id);
      final first = await database.select(database.tracks).getSingle();
      await before.rename(
        '${directory.path}${Platform.pathSeparator}after.mp3',
      );
      await scan.scanAndWait(root.id);
      final second = await database.select(database.tracks).getSingle();
      expect(second.publicId, first.publicId);
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
      expect(album.artist, 'Tagged Artist');
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

  test(
    'metadata failure records a playable fallback track and completes scan',
    () async {
      final source = File(
        '${directory.path}${Platform.pathSeparator}broken.mp3',
      );
      await source.writeAsBytes([1]);
      final scan = LibraryScanCoordinator(
        database,
        metadataReader: const _FailingMetadataReader(),
      );
      addTearDown(scan.close);
      final root = (await facade.query.listRoots()).single;
      await scan.scanAndWait(root.id);
      final track = (await facade.query.listTracks()).single;
      final file = await database.select(database.mediaFiles).getSingle();
      expect(track.title, 'broken');
      expect(track.available, isTrue);
      expect(file.metadataState, 'failed');
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

final class _NullIdentityProvider implements FileIdentityProvider {
  @override
  Future<String?> getPlatformFileId(Uri locator) async => null;
}

final class _FailingEnumerator implements AudioFileEnumerator {
  const _FailingEnumerator();

  @override
  Stream<EnumeratedAudioFile> enumerate({
    required String root,
    required bool recursive,
  }) => Stream.error(FileSystemException('Enumeration failed', root));
}

final class _FixedEnumerator implements AudioFileEnumerator {
  const _FixedEnumerator(this._files);
  final List<EnumeratedAudioFile> _files;

  @override
  Stream<EnumeratedAudioFile> enumerate({
    required String root,
    required bool recursive,
  }) => Stream.fromIterable(_files);
}

final class _PausedEnumerator implements AudioFileEnumerator {
  final started = Completer<void>();
  final release = Completer<void>();

  @override
  Stream<EnumeratedAudioFile> enumerate({
    required String root,
    required bool recursive,
  }) async* {
    started.complete();
    await release.future;
  }
}

EnumeratedAudioFile _entry(File file, FileStat stat, String platformFileId) {
  final name = file.path.split(Platform.pathSeparator).last;
  return EnumeratedAudioFile(
    file: file,
    locator: file.path,
    locatorKey: file.path.toLowerCase(),
    relativePath: name,
    fileName: name,
    extension: 'mp3',
    stat: stat,
    platformFileId: platformFileId,
    quickFingerprint: null,
  );
}

final class _FailingMetadataReader implements TrackMetadataReader {
  const _FailingMetadataReader();

  @override
  Future<MetadataReadResult> read(EnumeratedAudioFile file) async =>
      MetadataReadResult.failed(
        const BasicTrackMetadata(
          title: 'broken',
          sortTitle: 'broken',
          searchText: 'broken',
          source: 'fileNameFallback',
        ),
        StateError('malformed tags'),
      );
}
