import 'package:drift/drift.dart';

import '../../../domain/library_models.dart' as domain;
import '../media_library_database.dart';

final class LibraryCollectionDao {
  LibraryCollectionDao(this._database);
  final MediaLibraryDatabase _database;

  Stream<List<domain.LibraryAlbum>> watchAlbums() {
    final query = _database.select(_database.albums).join([
      leftOuterJoin(
        _database.artists,
        _database.artists.rowId.equalsExp(_database.albums.albumArtistId),
      ),
    ])..orderBy([OrderingTerm.asc(_database.albums.sortTitle)]);
    return query.watch().map(
      (rows) => rows
          .map((row) {
            final album = row.readTable(_database.albums);
            final artist = row.readTableOrNull(_database.artists);
            return domain.LibraryAlbum(
              id: album.publicId,
              title: album.title,
              artist: artist?.name,
            );
          })
          .toList(growable: false),
    );
  }

  Stream<List<domain.LibraryArtist>> watchArtists() =>
      (_database.select(
        _database.artists,
      )..orderBy([(artist) => OrderingTerm.asc(artist.sortName)])).watch().map(
        (rows) => rows
            .map(
              (row) => domain.LibraryArtist(id: row.publicId, name: row.name),
            )
            .toList(growable: false),
      );
}
