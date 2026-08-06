import 'dart:async';

import 'package:platform_bridge/platform_bridge.dart';
import 'package:playback_protocol/playback_protocol.dart' as protocol;
import 'package:smtc_windows/smtc_windows.dart';

final class SmtcWindowsMediaSessionAdapter implements WindowsMediaSessionPort {
  SMTCWindows? _smtc;
  final _commands = StreamController<WindowsMediaCommand>.broadcast();
  StreamSubscription<PressedButton>? _buttons;

  @override
  bool get supportsSystemSeekRequest => false;

  @override
  Stream<WindowsMediaCommand> get commands => _commands.stream;

  @override
  Future<void> initialize() async {
    await SMTCWindows.initialize();
    final smtc = SMTCWindows(
      config: const SMTCConfig(
        playEnabled: true,
        pauseEnabled: true,
        nextEnabled: true,
        prevEnabled: true,
        stopEnabled: true,
        fastForwardEnabled: false,
        rewindEnabled: false,
      ),
    );
    _smtc = smtc;
    _buttons = smtc.buttonPressStream.listen((button) {
      final type = switch (button) {
        PressedButton.play => WindowsMediaCommandType.play,
        PressedButton.pause => WindowsMediaCommandType.pause,
        PressedButton.next => WindowsMediaCommandType.next,
        PressedButton.previous => WindowsMediaCommandType.previous,
        PressedButton.stop => WindowsMediaCommandType.stop,
        _ => null,
      };
      if (type != null) _commands.add(WindowsMediaCommand(type));
    });
  }

  @override
  Future<void> updatePlaybackState(protocol.PlaybackStatus status) async {
    final value = switch (status) {
      protocol.PlaybackStatus.playing => PlaybackStatus.playing,
      protocol.PlaybackStatus.paused => PlaybackStatus.paused,
      protocol.PlaybackStatus.stopped ||
      protocol.PlaybackStatus.idle => PlaybackStatus.stopped,
      _ => PlaybackStatus.changing,
    };
    await _smtc?.setPlaybackStatus(value);
  }

  @override
  Future<void> updateMetadata({
    required String title,
    String? artist,
    String? album,
    String? artwork,
  }) async {
    await _smtc?.updateMetadata(
      MusicMetadata(
        title: title,
        artist: artist,
        album: album,
        thumbnail: artwork,
      ),
    );
  }

  @override
  Future<void> updateTimeline({
    required Duration position,
    required Duration duration,
  }) async {
    await _smtc?.updateTimeline(
      PlaybackTimeline(
        startTimeMs: 0,
        endTimeMs: duration.inMilliseconds,
        positionMs: position.inMilliseconds,
        minSeekTimeMs: 0,
        maxSeekTimeMs: duration.inMilliseconds,
      ),
    );
  }

  @override
  Future<void> clearMetadata() async => _smtc?.clearMetadata();
  @override
  Future<void> setEnabled(bool enabled) async =>
      enabled ? _smtc?.enableSmtc() : _smtc?.disableSmtc();
  @override
  Future<void> dispose() async {
    await _buttons?.cancel();
    await _smtc?.dispose();
    await _commands.close();
  }
}
