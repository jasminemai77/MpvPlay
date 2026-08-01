import 'package:drift/drift.dart';

import '../../../domain/library_models.dart' as domain;
import '../media_library_database.dart';

final class LibraryTrackDao {
  LibraryTrackDao(this._database);
  final MediaLibraryDatabase _database;

  Future<List<domain.LibraryTrack>> list({
    int limit = 200,
    int offset = 0,
  }) async {
    final query = _baseQuery()
      ..orderBy([OrderingTerm.asc(_database.tracks.sortTitle)])
      ..limit(limit, offset: offset);
    return (await query.get()).map(_map).toList(growable: false);
  }

  Stream<List<domain.LibraryTrack>> watchAll({int limit = 200}) {
    final query = _baseQuery()
      ..orderBy([OrderingTerm.asc(_database.tracks.sortTitle)])
      ..limit(limit);
    return query.watch().map((rows) => rows.map(_map).toList(growable: false));
  }

  Future<List<domain.LibraryTrack>> searchLike(
    String normalizedQuery, {
    int limit = 100,
  }) async {
    if (normalizedQuery.isEmpty) return list(limit: limit);
    final query = _baseQuery()
      ..where(
        _database.tracks.searchText.lower().like(
          '%${normalizedQuery.toLowerCase()}%',
        ),
      )
      ..orderBy([OrderingTerm.asc(_database.tracks.sortTitle)])
      ..limit(limit);
    return (await query.get()).map(_map).toList(growable: false);
  }

  Future<List<domain.LibraryTrack>> searchFts(String query) async {
    final matches = await _database.searchTracksFts(query).get();
    final tracks = <domain.LibraryTrack>[];
    for (final match in matches) {
      final row =
          await (_baseQuery()..where(
                _database.tracks.publicId.equals(match.trackPublicId ?? ''),
              ))
              .getSingleOrNull();
      if (row != null) tracks.add(_map(row));
    }
    return tracks;
  }

  JoinedSelectStatement _baseQuery() =>
      _database.select(_database.tracks).join([
        innerJoin(
          _database.mediaFiles,
          _database.mediaFiles.rowId.equalsExp(_database.tracks.mediaFileId),
        ),
      ]);

  domain.LibraryTrack _map(TypedResult row) {
    final track = row.readTable(_database.tracks);
    final mediaFile = row.readTable(_database.mediaFiles);
    return domain.LibraryTrack(
      id: track.publicId,
      mediaFileId: mediaFile.publicId,
      title: track.title,
      displayArtist: track.displayArtist,
      displayAlbum: track.displayAlbum,
      duration: track.durationMs == null
          ? null
          : Duration(milliseconds: track.durationMs!),
      locator: Uri.file(mediaFile.locator, windows: true),
      available: mediaFile.availabilityState == 'available',
    );
  }
}
