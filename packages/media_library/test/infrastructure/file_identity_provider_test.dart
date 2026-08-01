import 'dart:io';

import 'package:media_library/src/infrastructure/filesystem/file_identity_provider.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Windows File ID is stable across rename and same-volume move',
    () async {
      if (!Platform.isWindows) return;
      final directory = await Directory.systemTemp.createTemp(
        'mpvplay-file-id-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final source = File(
        '${directory.path}${Platform.pathSeparator}source.mp3',
      );
      await source.writeAsBytes([1]);
      const provider = WindowsFileIdentityProvider();
      final before = await provider.getPlatformFileId(source.uri);
      expect(before, isNotNull);
      final renamed = await source.rename(
        '${directory.path}${Platform.pathSeparator}renamed.mp3',
      );
      final afterRename = await provider.getPlatformFileId(renamed.uri);
      expect(afterRename, before);
      final movedDirectory = await Directory(
        '${directory.path}${Platform.pathSeparator}moved',
      ).create();
      final moved = await renamed.rename(
        '${movedDirectory.path}${Platform.pathSeparator}moved.mp3',
      );
      expect(await provider.getPlatformFileId(moved.uri), before);
    },
  );
}
