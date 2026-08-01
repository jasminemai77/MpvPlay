import 'dart:io';

import 'package:crypto/crypto.dart';

import 'path_normalizer.dart';
import 'file_identity_provider.dart';

final class EnumeratedAudioFile {
  const EnumeratedAudioFile({
    required this.file,
    required this.locator,
    required this.locatorKey,
    required this.relativePath,
    required this.fileName,
    required this.extension,
    required this.stat,
    required this.platformFileId,
    required this.quickFingerprint,
  });
  final File file;
  final String locator;
  final String locatorKey;
  final String relativePath;
  final String fileName;
  final String extension;
  final FileStat stat;
  final String? platformFileId;
  final String? quickFingerprint;
}

abstract interface class AudioFileEnumerator {
  Stream<EnumeratedAudioFile> enumerate({
    required String root,
    required bool recursive,
  });
}

final class DirectoryEnumerator implements AudioFileEnumerator {
  DirectoryEnumerator({
    WindowsPathNormalizer? normalizer,
    FileIdentityProvider? identityProvider,
  }) : _normalizer = normalizer ?? const WindowsPathNormalizer(),
       _identityProvider =
           identityProvider ?? const WindowsFileIdentityProvider();
  final WindowsPathNormalizer _normalizer;
  final FileIdentityProvider _identityProvider;

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

  @override
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
      final stat = await entity.stat();
      yield EnumeratedAudioFile(
        file: entity,
        locator: locator,
        locatorKey: _normalizer.locatorKey(locator),
        relativePath: _normalizer.relativeToRoot(root, locator),
        fileName: name,
        extension: extension,
        stat: stat,
        platformFileId: await _identityProvider.getPlatformFileId(
          Uri.file(locator, windows: true),
        ),
        quickFingerprint: await _quickFingerprint(entity, stat),
      );
    }
  }

  /// A rename candidate only: it is never a durable content identity.
  Future<String?> _quickFingerprint(File file, FileStat stat) async {
    try {
      final handle = await file.open();
      try {
        final bytes = await handle.read(
          stat.size < 64 * 1024 ? stat.size : 64 * 1024,
        );
        return '${stat.size}:${sha256.convert(bytes)}';
      } finally {
        await handle.close();
      }
    } on FileSystemException {
      return null;
    }
  }
}
