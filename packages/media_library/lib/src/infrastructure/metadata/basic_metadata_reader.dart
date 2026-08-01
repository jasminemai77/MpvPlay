import '../filesystem/directory_enumerator.dart';

final class BasicTrackMetadata {
  const BasicTrackMetadata({
    required this.title,
    required this.sortTitle,
    required this.searchText,
    required this.source,
  });
  final String title;
  final String sortTitle;
  final String searchText;
  final String source;
}

/// Safe first-pass metadata fallback. Native tag parsing can enrich this later.
final class BasicMetadataReader {
  const BasicMetadataReader();

  BasicTrackMetadata read(EnumeratedAudioFile file) {
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
