import 'package:media_library/media_library.dart';
import 'package:test/test.dart';

void main() {
  test('library track keeps a public track id distinct from media file id', () {
    final track = LibraryTrack(
      id: 'track-v7',
      mediaFileId: 'file-v7',
      title: 'Tone',
      locator: Uri.file('tone.wav'),
      available: true,
    );
    expect(track.id, isNot(track.mediaFileId));
  });
}
