import 'package:audio_metadata_reader/audio_metadata_reader.dart' as reader;

import '../filesystem/directory_enumerator.dart';
import 'basic_metadata_reader.dart';

/// Adapts a pure-Dart tag parser without exposing its third-party types.
final class AudioMetadataReaderAdapter implements TrackMetadataReader {
  AudioMetadataReaderAdapter({BasicMetadataReader? fallback})
    : _fallback = fallback ?? const BasicMetadataReader();
  final BasicMetadataReader _fallback;

  @override
  Future<MetadataReadResult> read(EnumeratedAudioFile file) async {
    final fallback = _fallback.readFallback(file);
    try {
      final tags = reader.readMetadata(file.file, getImage: true);
      final title = _present(tags.title) ?? fallback.title;
      final primaryArtist = _present(tags.artist);
      final artists = [
        ...?(primaryArtist == null ? null : [primaryArtist]),
        ...tags.performers.where((artist) => artist.trim().isNotEmpty),
      ];
      return MetadataReadResult.success(
        BasicTrackMetadata(
          title: title,
          sortTitle: title.toLowerCase(),
          searchText: [
            title,
            tags.album,
            ...artists,
            ...tags.genres,
            file.fileName,
          ].whereType<String>().join(' ').toLowerCase(),
          source: 'audioMetadataReader',
          album: _present(tags.album),
          artist: _present(tags.artist),
          artists: artists,
          genres: tags.genres,
          duration: tags.duration,
          bitrateBps: tags.bitrate,
          sampleRateHz: tags.sampleRate,
          trackNumber: tags.trackNumber,
          trackTotal: tags.trackTotal,
          discNumber: tags.discNumber,
          discTotal: tags.totalDisc,
          releaseYear: tags.year?.year,
          embeddedArtwork: tags.pictures.isEmpty
              ? null
              : EmbeddedArtwork(
                  tags.pictures.first.bytes,
                  tags.pictures.first.mimetype,
                ),
        ),
      );
    } catch (error) {
      return MetadataReadResult.failed(fallback, error);
    }
  }

  String? _present(String? value) =>
      value == null || value.trim().isEmpty ? null : value.trim();
}
