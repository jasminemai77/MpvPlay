import 'dart:io';

import 'path_normalizer.dart';

final class EnumeratedAudioFile {
  const EnumeratedAudioFile({
    required this.file,
    required this.locator,
    required this.locatorKey,
    required this.relativePath,
    required this.fileName,
    required this.extension,
    required this.stat,
  });
  final File file;
  final String locator;
  final String locatorKey;
  final String relativePath;
  final String fileName;
  final String extension;
  final FileStat stat;
}

final class DirectoryEnumerator {
  DirectoryEnumerator({WindowsPathNormalizer? normalizer})
    : _normalizer = normalizer ?? const WindowsPathNormalizer();
  final WindowsPathNormalizer _normalizer;

  static const supportedExtensions = <String>{
    'aac',
    'aiff',
    'alac',
    'ape',
    'flac',
    'm4a',
    'mka',
    'mp3',
    'mp4',
    'oga',
    'ogg',
    'opus',
    'wav',
    'wma',
    'wv',
  };

  Stream<EnumeratedAudioFile> enumerate({
    required String root,
    required bool recursive,
  }) async* {
    final directory = Directory(root);
    if (!await directory.exists()) {
      throw FileSystemException('Library root is unavailable', root);
    }
    await for (final entity in directory.list(
      recursive: recursive,
      followLinks: false,
    )) {
      if (entity is! File) continue;
      final name = entity.path.split(RegExp(r'[\\/]')).last;
      final dot = name.lastIndexOf('.');
      if (dot <= 0 || dot == name.length - 1) continue;
      final extension = name.substring(dot + 1).toLowerCase();
      if (!supportedExtensions.contains(extension)) continue;
      final locator = _normalizer.normalizeLocator(entity.path);
      yield EnumeratedAudioFile(
        file: entity,
        locator: locator,
        locatorKey: _normalizer.locatorKey(locator),
        relativePath: _normalizer.relativeToRoot(root, locator),
        fileName: name,
        extension: extension,
        stat: await entity.stat(),
      );
    }
  }
}
