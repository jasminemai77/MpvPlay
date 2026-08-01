import 'dart:io';

import 'package:test/test.dart';

import 'generate.dart';

void main() {
  group('generateTestMedia', () {
    test('keeps WAV fixtures when ffmpeg is unavailable', () async {
      final output = await Directory.systemTemp.createTemp('mpvplay-fixtures-');
      addTearDown(() => output.delete(recursive: true));

      final result = await generateTestMedia(
        outputDirectory: output,
        processRunner: _missingFfmpeg,
      );

      expect(result['status'], 'SKIPPED');
      expect(
        await File(
          '${output.path}${Platform.pathSeparator}tone-440hz.wav',
        ).exists(),
        isTrue,
      );
      expect(
        await File('${output.path}${Platform.pathSeparator}tone.mp3').exists(),
        isFalse,
      );
    });

    test('reports GENERATED when ffmpeg and all codecs succeed', () async {
      final output = await Directory.systemTemp.createTemp('mpvplay-fixtures-');
      addTearDown(() => output.delete(recursive: true));

      final result = await generateTestMedia(
        outputDirectory: output,
        processRunner: _successfulFfmpeg,
      );

      expect(result, {'status': 'GENERATED'});
    });

    test('skips compressed fixtures when a codec is unavailable', () async {
      final output = await Directory.systemTemp.createTemp('mpvplay-fixtures-');
      addTearDown(() => output.delete(recursive: true));

      final result = await generateTestMedia(
        outputDirectory: output,
        processRunner: _codecUnavailable,
      );

      expect(result['status'], 'SKIPPED');
      expect(result['reason'], 'ffmpeg codec libmp3lame unavailable');
      expect(
        await File(
          '${output.path}${Platform.pathSeparator}tone-440hz.wav',
        ).exists(),
        isTrue,
      );
    });
  });
}

Future<ProcessResult> _missingFfmpeg(
  String executable,
  List<String> arguments, {
  bool runInShell = false,
}) => Future<ProcessResult>.error(
  ProcessException(
    executable,
    arguments,
    'The system cannot find the file specified.',
  ),
);

Future<ProcessResult> _successfulFfmpeg(
  String executable,
  List<String> arguments, {
  bool runInShell = false,
}) async => ProcessResult(1, 0, '', '');

Future<ProcessResult> _codecUnavailable(
  String executable,
  List<String> arguments, {
  bool runInShell = false,
}) async => ProcessResult(1, arguments.first == '-version' ? 0 : 1, '', '');
