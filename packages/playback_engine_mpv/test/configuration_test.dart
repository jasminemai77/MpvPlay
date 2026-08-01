import 'package:playback_engine_mpv/playback_engine_mpv.dart';
import 'package:test/test.dart';

void main() {
  test('production configuration keeps audio output enabled', () {
    expect(const MpvEngineConfiguration().enableAudioOutput, isTrue);
  });

  test('silent configuration is explicit and adapter-local', () {
    expect(
      const MpvEngineConfiguration(enableAudioOutput: false).enableAudioOutput,
      isFalse,
    );
  });
}
