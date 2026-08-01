import 'dart:io';

import 'package:media_library/src/infrastructure/artwork/artwork_store.dart';
import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  test(
    'artwork cache deduplicates hashes and persists only a relative path',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'mpvplay-artwork-',
      );
      final database = MediaLibraryDatabase(openInMemoryMediaLibraryDatabase());
      addTearDown(() async {
        await database.close();
        await directory.delete(recursive: true);
      });
      final store = ArtworkStore(database, directory);
      final first = await store.put([1, 2, 3], mimeType: 'image/jpeg');
      final second = await store.put([1, 2, 3], mimeType: 'image/jpeg');
      expect(second.rowId, first.rowId);
      expect(first.relativeCachePath, startsWith('artwork/'));
      expect(await store.resolve(first).exists(), isTrue);
      expect(await database.select(database.artworkAssets).get(), hasLength(1));
    },
  );
}
