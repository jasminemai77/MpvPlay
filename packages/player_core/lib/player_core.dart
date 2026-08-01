enum MediaKind { audio, video }

final class MediaSource {
  const MediaSource({required this.id, required this.uri, required this.kind});
  final String id;
  final Uri uri;
  final MediaKind kind;

  @override
  bool operator ==(Object other) =>
      other is MediaSource &&
      other.id == id &&
      other.uri == uri &&
      other.kind == kind;
  @override
  int get hashCode => Object.hash(id, uri, kind);
}

final class PlayableItem {
  const PlayableItem({
    required this.id,
    required this.title,
    this.artist,
    required this.source,
  });
  final String id;
  final String title;
  final String? artist;
  final MediaSource source;

  @override
  bool operator ==(Object other) =>
      other is PlayableItem &&
      other.id == id &&
      other.title == title &&
      other.artist == artist &&
      other.source == source;
  @override
  int get hashCode => Object.hash(id, title, artist, source);
}

final class PlaybackQueue {
  PlaybackQueue({required List<PlayableItem> items, required this.currentIndex})
    : items = List.unmodifiable(items) {
    if (currentIndex < -1 || currentIndex >= items.length) {
      throw RangeError.index(currentIndex, items, 'currentIndex');
    }
  }
  final List<PlayableItem> items;
  final int currentIndex;

  @override
  bool operator ==(Object other) =>
      other is PlaybackQueue &&
      other.currentIndex == currentIndex &&
      _listEquals(other.items, items);
  @override
  int get hashCode => Object.hash(Object.hashAll(items), currentIndex);
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
