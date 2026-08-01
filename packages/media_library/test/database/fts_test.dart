import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  test(
    'FTS5 trigram searches Chinese and English and can be rebuilt by row id',
    () async {
      final database = MediaLibraryDatabase(openInMemoryMediaLibraryDatabase());
      addTearDown(database.close);
      await database.insertTrackSearch(
        1,
        'track-cn',
        '七里香',
        '周杰伦',
        '七里香',
        '03-七里香.flac',
      );
      await database.insertTrackSearch(
        2,
        'track-en',
        'Love Story',
        'Taylor Swift',
        'Fearless',
        'love-story.flac',
      );
      expect(
        (await database.searchTracksFts('七里香').get()).single.trackPublicId,
        'track-cn',
      );
      expect(
        (await database.searchTracksFts('周杰伦').get()).single.trackPublicId,
        'track-cn',
      );
      expect(
        (await database.searchTracksFts('Love').get()).single.trackPublicId,
        'track-en',
      );
      expect(
        (await database.searchTracksFts('story').get()).single.trackPublicId,
        'track-en',
      );
      expect(await database.searchTracksFts('voidcontent').get(), isEmpty);
      await database.deleteTrackSearch(1);
      expect(await database.searchTracksFts('七里香').get(), isEmpty);
      await database.insertTrackSearch(
        1,
        'track-cn',
        '七里香',
        '周杰伦',
        '七里香',
        '03-七里香.flac',
      );
      expect(
        (await database.searchTracksFts('七里香').get()).map(
          (row) => row.trackRowId,
        ),
        [1],
      );
    },
  );
}
