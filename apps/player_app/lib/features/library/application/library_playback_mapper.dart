import 'package:media_library/media_library.dart';
import 'package:player_core/player_core.dart';

/// The sole app-layer bridge between persistent library rows and playback types.
final class LibraryPlaybackMapper {
  const LibraryPlaybackMapper();

  PlayableItem mapTrack(LibraryTrack track) => PlayableItem(
    id: track.id,
    title: track.title,
    artist: track.displayArtist,
    source: MediaSource(
      id: track.mediaFileId,
      uri: track.locator,
      kind: MediaKind.audio,
    ),
  );
}
