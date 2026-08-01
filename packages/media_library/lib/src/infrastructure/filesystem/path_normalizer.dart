import 'dart:io';

/// Windows path normalization used only for locator comparison and identity keys.
final class WindowsPathNormalizer {
  const WindowsPathNormalizer();

  String normalizeLocator(String value) {
    final absolute = File(value).absolute.path.replaceAll('/', r'\\');
    return _trimTrailingSeparator(absolute);
  }

  String locatorKey(String value) => normalizeLocator(value).toLowerCase();

  bool overlaps(String first, String second) {
    final a = locatorKey(first);
    final b = locatorKey(second);
    return a == b || a.startsWith('$b\\') || b.startsWith('$a\\');
  }

  String relativeToRoot(String root, String locator) {
    final rootKey = locatorKey(root);
    final fileKey = locatorKey(locator);
    if (fileKey == rootKey) return '';
    if (!fileKey.startsWith('$rootKey\\')) {
      throw ArgumentError.value(locator, 'locator', 'must be inside root');
    }
    return normalizeLocator(
      locator,
    ).substring(normalizeLocator(root).length + 1);
  }

  String _trimTrailingSeparator(String value) {
    if (value.length <= 3) return value;
    return value.endsWith(r'\\') ? value.substring(0, value.length - 1) : value;
  }
}
