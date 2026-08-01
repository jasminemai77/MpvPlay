import 'dart:io';

import 'package:media_library/media_library.dart';
import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
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

  test('overlapping directory roots are rejected before persistence', () async {
    final nested = await Directory(
      '${directory.path}${Platform.pathSeparator}nested',
    ).create();
    await expectLater(
      facade.addDirectoryRoot(locator: nested.path, displayName: 'Nested root'),
      throwsA(isA<LibraryRootOverlapException>()),
    );
  });
}
