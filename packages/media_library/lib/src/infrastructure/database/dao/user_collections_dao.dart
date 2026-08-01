import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/library_models.dart' as domain;
import '../media_library_database.dart';
import 'library_track_dao.dart';

/// Drift-only persistence for favorites and user-owned playlist definitions.
final class UserCollectionsDao {
  UserCollectionsDao(this._database, this._tracks);
  final MediaLibraryDatabase _database;
  final LibraryTrackDao _tracks;
  static const _uuid = Uuid();

  Stream<List<domain.LibraryTrack>> watchFavoriteTracks() {
    final query =
        _database.select(_database.favoriteTracks).join([
            innerJoin(
              _database.tracks,
              _database.tracks.rowId.equalsExp(
                _database.favoriteTracks.trackId,
              ),
            ),
            innerJoin(
              _database.mediaFiles,
              _database.mediaFiles.rowId.equalsExp(
                _database.tracks.mediaFileId,
              ),
            ),
          ])
          ..where(_database.mediaFiles.availabilityState.equals('available'))
          ..orderBy([
            OrderingTerm.desc(_database.favoriteTracks.createdAt),
            OrderingTerm.desc(_database.favoriteTracks.trackId),
          ]);
    return query.watch().map(
      (rows) => rows.map(_tracks.mapJoinedRow).toList(growable: false),
    );
  }

  Stream<int> watchMissingFavoriteCount() {
    final query = _database.select(_database.favoriteTracks).join([
      innerJoin(
        _database.tracks,
        _database.tracks.rowId.equalsExp(_database.favoriteTracks.trackId),
      ),
      innerJoin(
        _database.mediaFiles,
        _database.mediaFiles.rowId.equalsExp(_database.tracks.mediaFileId),
      ),
    ])..where(_database.mediaFiles.availabilityState.isNotValue('available'));
    return query.watch().map((rows) => rows.length);
  }

  Stream<bool> watchIsFavorite(String trackPublicId) {
    final query = _database.select(_database.tracks).join([
      leftOuterJoin(
        _database.favoriteTracks,
        _database.favoriteTracks.trackId.equalsExp(_database.tracks.rowId),
      ),
    ])..where(_database.tracks.publicId.equals(trackPublicId));
    return query.watch().map(
      (rows) =>
          rows.isNotEmpty &&
          rows.first.readTableOrNull(_database.favoriteTracks) != null,
    );
  }

  Future<void> setFavorite(String trackPublicId, bool favorite) =>
      _database.transaction(() async {
        final track = await _trackByPublicId(trackPublicId);
        if (track == null) {
          throw const domain.CollectionFailure(
            domain.CollectionFailureCode.trackNotFound,
          );
        }
        if (favorite) {
          await _database
              .into(_database.favoriteTracks)
              .insert(
                FavoriteTracksCompanion.insert(
                  trackId: Value(track.rowId),
                  createdAt: DateTime.now().toUtc(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        } else {
          await (_database.delete(
            _database.favoriteTracks,
          )..where((row) => row.trackId.equals(track.rowId))).go();
        }
      });

  Stream<List<domain.UserPlaylist>> watchPlaylists() {
    final query = _database.select(_database.userPlaylists).join([
      leftOuterJoin(
        _database.userPlaylistItems,
        _database.userPlaylistItems.playlistId.equalsExp(
          _database.userPlaylists.rowId,
        ),
      ),
    ])..orderBy([OrderingTerm.desc(_database.userPlaylists.updatedAt)]);
    return query.watch().map(_mapPlaylists);
  }

  Stream<domain.UserPlaylistDetail?> watchPlaylist(String playlistPublicId) {
    final query =
        _database.select(_database.userPlaylists).join([
            leftOuterJoin(
              _database.userPlaylistItems,
              _database.userPlaylistItems.playlistId.equalsExp(
                _database.userPlaylists.rowId,
              ),
            ),
            leftOuterJoin(
              _database.tracks,
              _database.tracks.rowId.equalsExp(
                _database.userPlaylistItems.trackId,
              ),
            ),
            leftOuterJoin(
              _database.mediaFiles,
              _database.mediaFiles.rowId.equalsExp(
                _database.tracks.mediaFileId,
              ),
            ),
          ])
          ..where(_database.userPlaylists.publicId.equals(playlistPublicId))
          ..orderBy([OrderingTerm.asc(_database.userPlaylistItems.position)]);
    return query.watch().map((rows) {
      if (rows.isEmpty) return null;
      final playlist = rows.first.readTable(_database.userPlaylists);
      final tracks = <domain.LibraryTrack>[];
      for (final row in rows) {
        if (row.readTableOrNull(_database.userPlaylistItems) != null &&
            row.readTableOrNull(_database.tracks) != null &&
            row.readTableOrNull(_database.mediaFiles) != null) {
          tracks.add(_tracks.mapJoinedRow(row));
        }
      }
      return domain.UserPlaylistDetail(
        playlist: _playlist(playlist, tracks.length),
        tracks: tracks,
      );
    });
  }

  Future<domain.UserPlaylist> createPlaylist({
    required String name,
    String? description,
  }) async {
    final normalized = _normalizeName(name);
    if (normalized.isEmpty) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.invalidPlaylistName,
      );
    }
    final now = DateTime.now().toUtc();
    final id = await _database
        .into(_database.userPlaylists)
        .insert(
          UserPlaylistsCompanion.insert(
            publicId: _uuid.v7(),
            name: name.trim(),
            normalizedName: normalized,
            description: Value(_blankToNull(description)),
            createdAt: now,
            updatedAt: now,
          ),
        );
    final row = await (_database.select(
      _database.userPlaylists,
    )..where((playlist) => playlist.rowId.equals(id))).getSingle();
    return _playlist(row, 0);
  }

  Future<void> renamePlaylist(String playlistPublicId, String name) async {
    final normalized = _normalizeName(name);
    if (normalized.isEmpty) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.invalidPlaylistName,
      );
    }
    final changed =
        await (_database.update(
          _database.userPlaylists,
        )..where((row) => row.publicId.equals(playlistPublicId))).write(
          UserPlaylistsCompanion(
            name: Value(name.trim()),
            normalizedName: Value(normalized),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
    if (changed == 0) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.playlistNotFound,
      );
    }
  }

  Future<void> deletePlaylist(String playlistPublicId) async {
    final deleted = await (_database.delete(
      _database.userPlaylists,
    )..where((row) => row.publicId.equals(playlistPublicId))).go();
    if (deleted == 0) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.playlistNotFound,
      );
    }
  }

  Future<void> addTrackToPlaylist(
    String playlistPublicId,
    String trackPublicId,
  ) => _database.transaction(() async {
    final playlist = await _playlistByPublicId(playlistPublicId);
    if (playlist == null) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.playlistNotFound,
      );
    }
    final track = await _trackByPublicId(trackPublicId);
    if (track == null) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.trackNotFound,
      );
    }
    final duplicate =
        await (_database.select(_database.userPlaylistItems)..where(
              (row) =>
                  row.playlistId.equals(playlist.rowId) &
                  row.trackId.equals(track.rowId),
            ))
            .getSingleOrNull();
    if (duplicate != null) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.duplicatePlaylistTrack,
      );
    }
    final last =
        await (_database.select(_database.userPlaylistItems)
              ..where((row) => row.playlistId.equals(playlist.rowId))
              ..orderBy([(row) => OrderingTerm.desc(row.position)]))
            .getSingleOrNull();
    await _database
        .into(_database.userPlaylistItems)
        .insert(
          UserPlaylistItemsCompanion.insert(
            playlistId: playlist.rowId,
            trackId: track.rowId,
            position: (last?.position ?? -1024) + 1024,
            addedAt: DateTime.now().toUtc(),
          ),
        );
    await _touchPlaylist(playlist.rowId);
  });

  Future<void> removeTrackFromPlaylist(
    String playlistPublicId,
    String trackPublicId,
  ) => _database.transaction(() async {
    final playlist = await _playlistByPublicId(playlistPublicId);
    if (playlist == null) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.playlistNotFound,
      );
    }
    final track = await _trackByPublicId(trackPublicId);
    if (track == null) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.trackNotFound,
      );
    }
    await (_database.delete(_database.userPlaylistItems)..where(
          (row) =>
              row.playlistId.equals(playlist.rowId) &
              row.trackId.equals(track.rowId),
        ))
        .go();
    await _touchPlaylist(playlist.rowId);
  });

  Future<void> reorderPlaylistTracks(
    String playlistPublicId,
    List<String> orderedTrackIds,
  ) => _database.transaction(() async {
    final playlist = await _playlistByPublicId(playlistPublicId);
    if (playlist == null) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.playlistNotFound,
      );
    }
    final existing =
        await (_database.select(_database.userPlaylistItems).join([
              innerJoin(
                _database.tracks,
                _database.tracks.rowId.equalsExp(
                  _database.userPlaylistItems.trackId,
                ),
              ),
            ])..where(
              _database.userPlaylistItems.playlistId.equals(playlist.rowId),
            ))
            .get();
    final byPublicId = <String, UserPlaylistItem>{
      for (final row in existing)
        row.readTable(_database.tracks).publicId: row.readTable(
          _database.userPlaylistItems,
        ),
    };
    if (orderedTrackIds.toSet().length != orderedTrackIds.length ||
        byPublicId.length != orderedTrackIds.length ||
        !orderedTrackIds.every(byPublicId.containsKey)) {
      throw const domain.CollectionFailure(
        domain.CollectionFailureCode.invalidTrackOrder,
      );
    }
    for (var index = 0; index < orderedTrackIds.length; index++) {
      await (_database.update(_database.userPlaylistItems)..where(
            (row) =>
                row.rowId.equals(byPublicId[orderedTrackIds[index]]!.rowId),
          ))
          .write(UserPlaylistItemsCompanion(position: Value(1000000 + index)));
    }
    for (var index = 0; index < orderedTrackIds.length; index++) {
      await (_database.update(_database.userPlaylistItems)..where(
            (row) =>
                row.rowId.equals(byPublicId[orderedTrackIds[index]]!.rowId),
          ))
          .write(UserPlaylistItemsCompanion(position: Value(index * 1024)));
    }
    await _touchPlaylist(playlist.rowId);
  });

  List<domain.UserPlaylist> _mapPlaylists(List<TypedResult> rows) {
    final counts = <int, int>{};
    final playlists = <int, UserPlaylist>{};
    for (final row in rows) {
      final playlist = row.readTable(_database.userPlaylists);
      playlists[playlist.rowId] = playlist;
      if (row.readTableOrNull(_database.userPlaylistItems) != null) {
        counts[playlist.rowId] = (counts[playlist.rowId] ?? 0) + 1;
      }
    }
    return playlists.values
        .map((row) => _playlist(row, counts[row.rowId] ?? 0))
        .toList(growable: false);
  }

  domain.UserPlaylist _playlist(UserPlaylist row, int trackCount) =>
      domain.UserPlaylist(
        id: row.publicId,
        name: row.name,
        description: row.description,
        trackCount: trackCount,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  Future<UserPlaylist?> _playlistByPublicId(String id) => (_database.select(
    _database.userPlaylists,
  )..where((row) => row.publicId.equals(id))).getSingleOrNull();

  Future<Track?> _trackByPublicId(String id) => (_database.select(
    _database.tracks,
  )..where((row) => row.publicId.equals(id))).getSingleOrNull();

  Future<void> _touchPlaylist(int rowId) =>
      (_database.update(
        _database.userPlaylists,
      )..where((row) => row.rowId.equals(rowId))).write(
        UserPlaylistsCompanion(updatedAt: Value(DateTime.now().toUtc())),
      );

  String _normalizeName(String value) => value.trim().toLowerCase();
  String? _blankToNull(String? value) =>
      value == null || value.trim().isEmpty ? null : value.trim();
}
