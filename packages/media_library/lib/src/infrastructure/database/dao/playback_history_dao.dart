import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/library_models.dart' as domain;
import '../media_library_database.dart';
import 'library_track_dao.dart';

/// Drift-only storage for append-only playback events and their aggregates.
final class PlaybackHistoryDao {
  PlaybackHistoryDao(this._database, this._tracks);

  static const _uuid = Uuid();
  static const maxRetainedEntries = 10000;

  final MediaLibraryDatabase _database;
  final LibraryTrackDao _tracks;

  Stream<List<domain.PlaybackHistoryEntry>> watchRecent({int limit = 200}) {
    final boundedLimit = limit.clamp(1, 200);
    final query =
        _database.select(_database.playbackHistoryEntries).join([
            innerJoin(
              _database.tracks,
              _database.tracks.rowId.equalsExp(
                _database.playbackHistoryEntries.trackId,
              ),
            ),
            innerJoin(
              _database.mediaFiles,
              _database.mediaFiles.rowId.equalsExp(
                _database.tracks.mediaFileId,
              ),
            ),
            innerJoin(
              _database.trackPlaybackStats,
              _database.trackPlaybackStats.trackId.equalsExp(
                _database.playbackHistoryEntries.trackId,
              ),
            ),
          ])
          ..orderBy([
            OrderingTerm.desc(_database.playbackHistoryEntries.startedAt),
            OrderingTerm.desc(_database.playbackHistoryEntries.rowId),
          ])
          ..limit(boundedLimit);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => domain.PlaybackHistoryEntry(
              id: row.readTable(_database.playbackHistoryEntries).publicId,
              track: _tracks.mapJoinedRow(row),
              startedAt: row
                  .readTable(_database.playbackHistoryEntries)
                  .startedAt,
              playCount: row.readTable(_database.trackPlaybackStats).playCount,
            ),
          )
          .toList(growable: false),
    );
  }

  Stream<domain.TrackPlaybackStats?> watchStats(String trackPublicId) {
    final query = _database.select(_database.tracks).join([
      innerJoin(
        _database.trackPlaybackStats,
        _database.trackPlaybackStats.trackId.equalsExp(_database.tracks.rowId),
      ),
    ])..where(_database.tracks.publicId.equals(trackPublicId));
    return query.watch().map((rows) {
      if (rows.isEmpty) return null;
      final stats = rows.first.readTable(_database.trackPlaybackStats);
      return domain.TrackPlaybackStats(
        trackId: trackPublicId,
        playCount: stats.playCount,
        firstPlayedAt: stats.firstPlayedAt,
        lastPlayedAt: stats.lastPlayedAt,
      );
    });
  }

  Stream<int> watchMissingTrackCount() {
    final query = _database.select(_database.playbackHistoryEntries).join([
      innerJoin(
        _database.tracks,
        _database.tracks.rowId.equalsExp(
          _database.playbackHistoryEntries.trackId,
        ),
      ),
      innerJoin(
        _database.mediaFiles,
        _database.mediaFiles.rowId.equalsExp(_database.tracks.mediaFileId),
      ),
    ])..where(_database.mediaFiles.availabilityState.isNotValue('available'));
    return query.watch().map((rows) => rows.length);
  }

  Future<void> recordStarted({
    required String trackPublicId,
    required String playbackSessionId,
    required DateTime startedAt,
  }) async {
    if (playbackSessionId.trim().isEmpty) {
      throw const domain.PlaybackHistoryFailure(
        domain.PlaybackHistoryFailureCode.invalidPlaybackSessionId,
      );
    }
    try {
      await _database.transaction(() async {
        final track =
            await (_database.select(_database.tracks)
                  ..where((row) => row.publicId.equals(trackPublicId)))
                .getSingleOrNull();
        if (track == null) {
          throw const domain.PlaybackHistoryFailure(
            domain.PlaybackHistoryFailureCode.trackNotFound,
          );
        }
        final duplicate =
            await (_database.select(_database.playbackHistoryEntries)..where(
                  (row) => row.playbackSessionId.equals(playbackSessionId),
                ))
                .getSingleOrNull();
        if (duplicate != null) return;
        final eventId = _uuid.v7();
        await _database
            .into(_database.playbackHistoryEntries)
            .insert(
              PlaybackHistoryEntriesCompanion.insert(
                publicId: eventId,
                playbackSessionId: playbackSessionId,
                trackId: track.rowId,
                startedAt: startedAt.toUtc(),
              ),
              mode: InsertMode.insertOrIgnore,
            );
        final inserted = await (_database.select(
          _database.playbackHistoryEntries,
        )..where((row) => row.publicId.equals(eventId))).getSingleOrNull();
        if (inserted == null) return;

        final existing = await (_database.select(
          _database.trackPlaybackStats,
        )..where((row) => row.trackId.equals(track.rowId))).getSingleOrNull();
        if (existing == null) {
          await _database
              .into(_database.trackPlaybackStats)
              .insert(
                TrackPlaybackStatsCompanion.insert(
                  trackId: Value(track.rowId),
                  playCount: 1,
                  firstPlayedAt: startedAt.toUtc(),
                  lastPlayedAt: startedAt.toUtc(),
                ),
              );
        } else {
          await (_database.update(
            _database.trackPlaybackStats,
          )..where((row) => row.trackId.equals(track.rowId))).write(
            TrackPlaybackStatsCompanion(
              playCount: Value(existing.playCount + 1),
              lastPlayedAt: Value(
                startedAt.isAfter(existing.lastPlayedAt)
                    ? startedAt.toUtc()
                    : existing.lastPlayedAt,
              ),
            ),
          );
        }
        await _trimRetainedEntries();
      });
    } on domain.PlaybackHistoryFailure {
      rethrow;
    } catch (error) {
      throw domain.PlaybackHistoryFailure(
        domain.PlaybackHistoryFailureCode.databaseFailure,
        message: '$error',
      );
    }
  }

  Future<void> clear() async {
    try {
      await _database.transaction(() async {
        await _database.delete(_database.playbackHistoryEntries).go();
        await _database.delete(_database.trackPlaybackStats).go();
      });
    } catch (error) {
      throw domain.PlaybackHistoryFailure(
        domain.PlaybackHistoryFailureCode.databaseFailure,
        message: '$error',
      );
    }
  }

  Future<void> _trimRetainedEntries() async {
    final stale =
        await (_database.select(_database.playbackHistoryEntries)
              ..orderBy([
                (row) => OrderingTerm.desc(row.startedAt),
                (row) => OrderingTerm.desc(row.rowId),
              ])
              ..limit(1, offset: maxRetainedEntries))
            .get();
    if (stale.isEmpty) return;
    await (_database.delete(
      _database.playbackHistoryEntries,
    )..where((row) => row.rowId.equals(stale.single.rowId))).go();
  }
}
