enum LibrarySourceType { windowsDirectory }

enum ScanStatus {
  idle,
  queued,
  enumerating,
  processing,
  committing,
  finalizing,
  completed,
  completedWithIssues,
  cancelled,
  failed,
}

enum LibraryFailureCode {
  rootUnavailable,
  rootPermissionDenied,
  rootOverlap,
  enumerationFailed,
  metadataFailed,
  artworkFailed,
  databaseFailed,
  cancelled,
  unknown,
}

final class LibraryRoot {
  const LibraryRoot({
    required this.id,
    required this.sourceType,
    required this.locator,
    required this.displayName,
    this.recursive = true,
    this.enabled = true,
    this.scanGeneration = 0,
  });
  final String id;
  final LibrarySourceType sourceType;
  final String locator;
  final String displayName;
  final bool recursive;
  final bool enabled;
  final int scanGeneration;
}

final class LibraryTrack {
  const LibraryTrack({
    required this.id,
    required this.mediaFileId,
    required this.title,
    this.displayArtist,
    this.displayAlbum,
    this.duration,
    required this.locator,
    required this.available,
  });
  final String id;
  final String mediaFileId;
  final String title;
  final String? displayArtist;
  final String? displayAlbum;
  final Duration? duration;
  final Uri locator;
  final bool available;
}

final class LibraryAlbum {
  const LibraryAlbum({required this.id, required this.title, this.artist});
  final String id;
  final String title;
  final String? artist;
}

final class LibraryArtist {
  const LibraryArtist({required this.id, required this.name});
  final String id;
  final String name;
}

final class FavoriteLibraryTrack {
  const FavoriteLibraryTrack({required this.track, required this.favoritedAt});
  final LibraryTrack track;
  final DateTime favoritedAt;
}

final class UserPlaylist {
  const UserPlaylist({
    required this.id,
    required this.name,
    required this.description,
    required this.trackCount,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String name;
  final String? description;
  final int trackCount;
  final DateTime createdAt;
  final DateTime updatedAt;
}

final class UserPlaylistDetail {
  const UserPlaylistDetail({required this.playlist, required this.tracks});
  final UserPlaylist playlist;
  final List<LibraryTrack> tracks;
}

final class PlaybackHistoryEntry {
  const PlaybackHistoryEntry({
    required this.id,
    required this.track,
    required this.startedAt,
    required this.playCount,
  });
  final String id;
  final LibraryTrack track;
  final DateTime startedAt;
  final int playCount;
}

final class TrackPlaybackStats {
  const TrackPlaybackStats({
    required this.trackId,
    required this.playCount,
    required this.firstPlayedAt,
    required this.lastPlayedAt,
  });
  final String trackId;
  final int playCount;
  final DateTime firstPlayedAt;
  final DateTime lastPlayedAt;
}

enum CollectionFailureCode {
  playlistNotFound,
  trackNotFound,
  duplicatePlaylistTrack,
  invalidPlaylistName,
  invalidTrackOrder,
  databaseFailure,
}

final class CollectionFailure implements Exception {
  const CollectionFailure(this.code, {this.message});
  final CollectionFailureCode code;
  final String? message;

  @override
  String toString() => 'CollectionFailure(${code.name}): ${message ?? ''}';
}

enum PlaybackHistoryFailureCode {
  trackNotFound,
  invalidPlaybackSessionId,
  databaseFailure,
}

final class PlaybackHistoryFailure implements Exception {
  const PlaybackHistoryFailure(this.code, {this.message});
  final PlaybackHistoryFailureCode code;
  final String? message;

  @override
  String toString() => 'PlaybackHistoryFailure(${code.name}): ${message ?? ''}';
}

final class LibrarySearchResult {
  const LibrarySearchResult({required this.track, required this.rank});
  final LibraryTrack track;
  final double rank;
}

final class LibraryFailure {
  const LibraryFailure(this.code, this.message, {this.technicalDetails});
  final LibraryFailureCode code;
  final String message;
  final String? technicalDetails;
}
