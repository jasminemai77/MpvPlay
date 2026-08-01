import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  late MediaLibraryDatabase database;

  setUp(
    () => database = MediaLibraryDatabase(openInMemoryMediaLibraryDatabase()),
  );
  tearDown(() => database.close());

  test('enforces unique keys, checks and invalid foreign keys', () async {
    await _root(database, id: 'root-1');
    await expectLater(_root(database, id: 'root-2'), throwsA(isA<Exception>()));
    await _exec(
      database,
      "INSERT INTO scan_runs(public_id, root_id, generation, status, started_at) VALUES ('scan-1', 1, 1, 'queued', ?)",
      [0],
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO scan_runs(public_id, root_id, generation, status, started_at) VALUES ('scan-2', 1, 1, 'queued', ?)",
        [0],
      ),
      throwsA(isA<Exception>()),
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO scan_runs(public_id, root_id, generation, status, started_at) VALUES ('scan-3', 999, 2, 'queued', ?)",
        [0],
      ),
      throwsA(isA<Exception>()),
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO media_files(public_id, root_id, locator, locator_key, relative_path, file_name, extension, size_bytes, modified_at_micros, availability_state, metadata_state, last_seen_generation, last_seen_at, created_at, updated_at) VALUES ('file-negative', 1, 'C:/a.flac', 'c:/a.flac', 'a.flac', 'a.flac', 'flac', -1, 0, 'available', 'pending', 0, ?, ?, ?)",
        _times3(),
      ),
      throwsA(isA<Exception>()),
    );
    await _file(database, id: 'file-1');
    await expectLater(_file(database, id: 'file-2'), throwsA(isA<Exception>()));
    await _exec(
      database,
      "INSERT INTO artists(public_id, name, sort_name, identity_key, created_at, updated_at) VALUES ('artist-1', 'Artist', 'Artist', 'artist', ?, ?)",
      _times(),
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO artists(public_id, name, sort_name, identity_key, created_at, updated_at) VALUES ('artist-2', 'Artist 2', 'Artist 2', 'artist', ?, ?)",
        _times(),
      ),
      throwsA(isA<Exception>()),
    );
    await _exec(
      database,
      "INSERT INTO albums(public_id, title, sort_title, identity_key, created_at, updated_at) VALUES ('album-1', 'Album', 'Album', 'album', ?, ?)",
      _times(),
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO albums(public_id, title, sort_title, identity_key, created_at, updated_at) VALUES ('album-2', 'Album 2', 'Album 2', 'album', ?, ?)",
        _times(),
      ),
      throwsA(isA<Exception>()),
    );
    await _exec(
      database,
      "INSERT INTO genres(public_id, name, identity_key, created_at, updated_at) VALUES ('genre-1', 'Rock', 'rock', ?, ?)",
      _times(),
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO genres(public_id, name, identity_key, created_at, updated_at) VALUES ('genre-2', 'Rock 2', 'rock', ?, ?)",
        _times(),
      ),
      throwsA(isA<Exception>()),
    );
    await _exec(
      database,
      "INSERT INTO artwork_assets(public_id, content_hash, mime_type, byte_length, relative_cache_path, created_at) VALUES ('art-1', 'hash', 'image/jpeg', 1, 'cover/a.jpg', ?)",
      [0],
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO artwork_assets(public_id, content_hash, mime_type, byte_length, relative_cache_path, created_at) VALUES ('art-2', 'hash', 'image/jpeg', 1, 'cover/b.jpg', ?)",
        [0],
      ),
      throwsA(isA<Exception>()),
    );
  });

  test('cascades join rows and sets artwork references to null', () async {
    await _root(database, id: 'root-1');
    await _file(database, id: 'file-1');
    await _exec(
      database,
      "INSERT INTO artists(public_id, name, sort_name, identity_key, created_at, updated_at) VALUES ('artist-1', 'Artist', 'Artist', 'artist', ?, ?)",
      _times(),
    );
    await _exec(
      database,
      "INSERT INTO genres(public_id, name, identity_key, created_at, updated_at) VALUES ('genre-1', 'Rock', 'rock', ?, ?)",
      _times(),
    );
    await _exec(
      database,
      "INSERT INTO artwork_assets(public_id, content_hash, mime_type, byte_length, relative_cache_path, created_at) VALUES ('art-1', 'hash', 'image/jpeg', 1, 'cover/a.jpg', ?)",
      [0],
    );
    await _exec(
      database,
      "INSERT INTO albums(public_id, title, sort_title, identity_key, artwork_id, created_at, updated_at) VALUES ('album-1', 'Album', 'Album', 'album', 1, ?, ?)",
      _times(),
    );
    await _exec(
      database,
      "INSERT INTO tracks(public_id, media_file_id, title, sort_title, album_id, metadata_revision, search_text, artwork_id, created_at, updated_at) VALUES ('track-1', 1, 'Track', 'Track', 1, 0, 'track', 1, ?, ?)",
      _times(),
    );
    await expectLater(
      _exec(
        database,
        "INSERT INTO tracks(public_id, media_file_id, title, sort_title, metadata_revision, search_text, created_at, updated_at) VALUES ('track-2', 1, 'Duplicate', 'Duplicate', 0, 'duplicate', ?, ?)",
        _times(),
      ),
      throwsA(isA<Exception>()),
    );
    await _exec(
      database,
      "INSERT INTO track_artists(track_id, artist_id, role, position) VALUES (1, 1, 'primary', 0)",
      [],
    );
    await _exec(
      database,
      'INSERT INTO track_genres(track_id, genre_id, position) VALUES (1, 1, 0)',
      [],
    );
    await _exec(database, 'DELETE FROM artwork_assets WHERE row_id = 1', []);
    final refs = await database
        .customSelect(
          'SELECT artwork_id FROM tracks UNION ALL SELECT artwork_id FROM albums',
        )
        .get();
    expect(
      refs.every((row) => row.readNullable<int>('artwork_id') == null),
      isTrue,
    );
    await _exec(database, 'DELETE FROM tracks WHERE row_id = 1', []);
    expect(
      await database.customSelect('SELECT * FROM track_artists').get(),
      isEmpty,
    );
    expect(
      await database.customSelect('SELECT * FROM track_genres').get(),
      isEmpty,
    );
  });
}

Future<void> _root(MediaLibraryDatabase db, {required String id}) => _exec(
  db,
  "INSERT INTO library_roots(public_id, source_type, locator, locator_key, display_name, created_at, updated_at) VALUES ('$id', 'windowsDirectory', 'C:/Music', 'c:/music', 'Music', ?, ?)",
  _times(),
);

Future<void> _file(MediaLibraryDatabase db, {required String id}) => _exec(
  db,
  "INSERT INTO media_files(public_id, root_id, locator, locator_key, relative_path, file_name, extension, size_bytes, modified_at_micros, availability_state, metadata_state, last_seen_generation, last_seen_at, created_at, updated_at) VALUES ('$id', 1, 'C:/Music/a.flac', 'c:/music/a.flac', 'a.flac', 'a.flac', 'flac', 1, 0, 'available', 'pending', 0, ?, ?, ?)",
  _times3(),
);

List<Object> _times() => [0, 0];
List<Object> _times3() => [..._times(), 0];
Future<void> _exec(
  MediaLibraryDatabase db,
  String sql,
  List<Object> variables,
) => db.customStatement(sql, variables);
