import '../filesystem/directory_enumerator.dart';

final class BasicTrackMetadata {
  const BasicTrackMetadata({
    required this.title,
    required this.sortTitle,
    required this.searchText,
    required this.source,
    this.album,
    this.artist,
    this.artists = const [],
    this.albumArtist,
    this.genres = const [],
    this.duration,
    this.bitrateBps,
    this.sampleRateHz,
    this.trackNumber,
    this.trackTotal,
    this.discNumber,
    this.discTotal,
    this.releaseYear,
    this.embeddedArtwork,
  });
  final String title;
  final String sortTitle;
  final String searchText;
  final String source;
  final String? album;
  final String? artist;
  final List<String> artists;
  final String? albumArtist;
  final List<String> genres;
  final Duration? duration;
  final int? bitrateBps;
  final int? sampleRateHz;
  final int? trackNumber;
  final int? trackTotal;
  final int? discNumber;
  final int? discTotal;
  final int? releaseYear;
  final EmbeddedArtwork? embeddedArtwork;
}

final class EmbeddedArtwork {
  const EmbeddedArtwork(this.bytes, this.mimeType);
  final List<int> bytes;
  final String mimeType;
}

final class MetadataReadResult {
  const MetadataReadResult.success(this.metadata) : failure = null;
  const MetadataReadResult.failed(this.metadata, this.failure);
  final BasicTrackMetadata metadata;
  final Object? failure;
  bool get isSuccess => failure == null;
}

abstract interface class TrackMetadataReader {
  Future<MetadataReadResult> read(EnumeratedAudioFile file);
}

/// Safe first-pass metadata fallback. Native tag parsing can enrich this later.
final class BasicMetadataReader implements TrackMetadataReader {
  const BasicMetadataReader();

  @override
  Future<MetadataReadResult> read(EnumeratedAudioFile file) async =>
      MetadataReadResult.success(readFallback(file));

  BasicTrackMetadata readFallback(EnumeratedAudioFile file) {
    final dot = file.fileName.lastIndexOf('.');
    final raw = file.fileName.substring(0, dot).replaceAll('_', ' ').trim();
    final title = raw
        .replaceFirst(RegExp(r'^\s*\d{1,3}\s*[-._ ]\s*'), '')
        .trim();
    final resolved = title.isEmpty ? raw : title;
    return BasicTrackMetadata(
      title: resolved,
      sortTitle: resolved.toLowerCase(),
      searchText: '$resolved ${file.fileName}'.toLowerCase(),
      source: 'fileNameFallback',
    );
  }
}
