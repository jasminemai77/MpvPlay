import 'package:media_library/src/infrastructure/filesystem/directory_enumerator.dart';
import 'package:media_library/src/infrastructure/filesystem/path_normalizer.dart';
import 'package:test/test.dart';

void main() {
  test('Windows path normalizer detects equal, parent, and child roots', () {
    const normalizer = WindowsPathNormalizer();
    expect(normalizer.overlaps(r'C:\Music', r'c:\music'), isTrue);
    expect(normalizer.overlaps(r'C:\Music', r'C:\Music\Albums'), isTrue);
    expect(normalizer.overlaps(r'C:\Music', r'C:\Podcasts'), isFalse);
  });

  test('supported scan extensions deliberately exclude MIDI fixtures', () {
    expect(DirectoryEnumerator.supportedExtensions, isNot(contains('mid')));
    expect(DirectoryEnumerator.supportedExtensions, isNot(contains('midi')));
  });
}
