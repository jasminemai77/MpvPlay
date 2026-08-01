import 'dart:io';

import 'package:media_library/src/infrastructure/filesystem/directory_enumerator.dart';
import 'package:media_library/src/infrastructure/metadata/audio_metadata_reader_adapter.dart';
import 'package:test/test.dart';

void main() {
  final adapter = AudioMetadataReaderAdapter();

  for (final extension in const ['wav', 'mp3', 'flac', 'm4a', 'ogg', 'opus']) {
    test('parses $extension fixture when available', () async {
      final file = File(
        '../../test_media/generated/${extension == 'wav' ? 'short-tone' : 'tone'}.$extension',
      );
      if (!await file.exists()) return;
      final stat = await file.stat();
      final result = await adapter.read(
        EnumeratedAudioFile(
          file: file,
          locator: file.absolute.path,
          locatorKey: file.absolute.path.toLowerCase(),
          relativePath: file.path,
          fileName: file.uri.pathSegments.last,
          extension: extension,
          stat: stat,
          platformFileId: null,
          quickFingerprint: null,
        ),
      );
      expect(
        result.isSuccess,
        isTrue,
        reason: '$extension must parse real audio metadata',
      );
      expect(result.metadata.duration, isNotNull);
      expect(result.metadata.sampleRateHz, isNotNull);
      if (extension == 'mp3') {
        expect(result.metadata.title, 'MpvPlay Fixture Song');
        expect(result.metadata.artist, 'MpvPlay Fixture Artist');
      }
    });
  }

  test(
    'metadata parser failure returns filename fallback without blocking playback',
    () async {
      final file = File('../../test_media/generated/random-bytes.bin');
      final result = await adapter.read(
        EnumeratedAudioFile(
          file: file,
          locator: file.absolute.path,
          locatorKey: file.absolute.path.toLowerCase(),
          relativePath: file.path,
          fileName: file.uri.pathSegments.last,
          extension: 'mp3',
          stat: await file.stat(),
          platformFileId: null,
          quickFingerprint: null,
        ),
      );
      expect(result.isSuccess, isFalse);
      expect(result.metadata.title, 'random-bytes');
    },
  );
}
