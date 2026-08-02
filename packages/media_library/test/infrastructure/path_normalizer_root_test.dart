import 'package:media_library/src/infrastructure/filesystem/path_normalizer.dart';
import 'package:test/test.dart';

void main() {
  const normalizer = WindowsPathNormalizer();
  test('normalizes separator, dot, parent and case variants consistently', () {
    final canonical = normalizer.locatorKey(r'D:\Music');
    expect(normalizer.locatorKey(r'd:\music\\'), canonical);
    expect(normalizer.locatorKey(r'D:\Music\.'), canonical);
    expect(normalizer.locatorKey(r'D:\Music\Albums\..'), canonical);
  });
  test('overlap observes path-segment boundaries', () {
    expect(normalizer.overlaps(r'D:\Music', r'D:\Music\Albums'), isTrue);
    expect(normalizer.overlaps(r'D:\Music', r'D:\MusicBackup'), isFalse);
  });
}
