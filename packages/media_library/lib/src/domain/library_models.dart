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
  });
  final String id;
  final LibrarySourceType sourceType;
  final String locator;
  final String displayName;
  final bool recursive;
  final bool enabled;
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

final class LibraryFailure {
  const LibraryFailure(this.code, this.message, {this.technicalDetails});
  final LibraryFailureCode code;
  final String message;
  final String? technicalDetails;
}
