import 'dart:io';

/// Windows path normalization used only for locator comparison and identity keys.
final class WindowsPathNormalizer {
  const WindowsPathNormalizer();

  String normalizeLocator(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, 'value', 'must not be empty');
    }
    final absolute = File(value).absolute.path.replaceAll('/', '\\');
    return _trimTrailingSeparator(_collapseSegments(absolute));
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
    var result = value;
    while (result.length > 3 && result.endsWith('\\')) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  String _collapseSegments(String value) {
    final parts = value.split('\\');
    final result = <String>[];
    for (final part in parts) {
      if (part.isEmpty && result.isEmpty) {
        result.add(part);
        continue;
      }
      if (part.isEmpty || part == '.') continue;
      if (part == '..') {
        if (result.length > 1) result.removeLast();
        continue;
      }
      result.add(part);
    }
    return result.join('\\');
  }
}
