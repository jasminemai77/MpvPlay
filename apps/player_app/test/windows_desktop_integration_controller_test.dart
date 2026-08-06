import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mpv_play/platform/windows/windows_desktop_integration_controller.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:platform_bridge/platform_bridge.dart';
import 'package:player_core/player_core.dart';

final class _Client implements PlaybackClient {
  _Client({this.sendDelay = Duration.zero});
  final Duration sendDelay;
  final snapshotsController = StreamController<PlaybackSnapshot>.broadcast();
  final commands = <PlaybackCommand>[];
  bool disposed = false;
  @override
  Stream<PlaybackSnapshot> get snapshots => snapshotsController.stream;
  @override
  Stream<PlaybackEvent> get events => const Stream.empty();
  @override
  Future<void> send(PlaybackCommand command) async {
    if (sendDelay > Duration.zero) await Future<void>.delayed(sendDelay);
    commands.add(command);
  }

  @override
  Future<void> dispose() async {
    disposed = true;
    await snapshotsController.close();
  }
}

PlaybackSnapshot _snapshot(
  PlaybackStatus status, {
  PlayableItem? item,
  Duration position = Duration.zero,
  Duration duration = Duration.zero,
}) => PlaybackSnapshot(
  sessionId: 'test',
  revision: 1,
  status: status,
  currentItem: item,
  position: position,
  duration: duration,
  queueItems: item == null ? const [] : [item],
  currentIndex: item == null ? -1 : 0,
  volume: 1,
  muted: false,
  failure: null,
);

PlayableItem _item() => PlayableItem(
  id: 'file:///track.mp3',
  title: 'Track A',
  artist: 'Artist',
  source: MediaSource(
    id: 'file:///track.mp3',
    uri: Uri.parse('file:///track.mp3'),
    kind: MediaKind.audio,
  ),
);

void main() {
  test(
    'initializes all ports and maps SMTC commands to runtime commands',
    () async {
      final client = _Client();
      final media = FakeWindowsMediaSessionPort();
      final tray = FakeDesktopTrayPort();
      final window = FakeDesktopWindowPort();
      final controller = WindowsDesktopIntegrationController(
        client: client,
        mediaSession: media,
        tray: tray,
        window: window,
        closeBehavior: () => WindowCloseBehavior.exitApplication,
        initialSnapshot: _snapshot(PlaybackStatus.paused),
      );
      await controller.initialize();
      expect(media.initialized, isTrue);
      expect(tray.initialized, isTrue);
      expect(window.initialized, isTrue);
      for (final command in [
        const WindowsMediaCommand(WindowsMediaCommandType.play),
        const WindowsMediaCommand(WindowsMediaCommandType.pause),
        const WindowsMediaCommand(WindowsMediaCommandType.next),
        const WindowsMediaCommand(WindowsMediaCommandType.previous),
        const WindowsMediaCommand(WindowsMediaCommandType.stop),
      ]) {
        media.emit(command);
        await Future<void>.delayed(Duration.zero);
      }
      expect(client.commands, everyElement(isA<PlaybackCommand>()));
      expect(client.commands.map((e) => e.runtimeType), [
        Play,
        Pause,
        SkipNext,
        SkipPrevious,
        Stop,
      ]);
      await controller.dispose();
      await client.dispose();
    },
  );

  test(
    'seek command is mapped only when position is supplied; adapter emits none',
    () async {
      final client = _Client();
      final media = FakeWindowsMediaSessionPort();
      final controller = WindowsDesktopIntegrationController(
        client: client,
        mediaSession: media,
        tray: FakeDesktopTrayPort(),
        window: FakeDesktopWindowPort(),
        closeBehavior: () => WindowCloseBehavior.exitApplication,
      );
      await controller.initialize();
      media.emit(const WindowsMediaCommand(WindowsMediaCommandType.seek));
      await Future<void>.delayed(Duration.zero);
      expect(client.commands, isEmpty);
      media.emit(
        const WindowsMediaCommand(
          WindowsMediaCommandType.seek,
          position: Duration(seconds: 9),
        ),
      );
      await Future<void>.delayed(Duration.zero);
      expect(client.commands.single, isA<Seek>());
      await controller.dispose();
      await client.dispose();
    },
  );

  test(
    'snapshot updates SMTC timeline/metadata and tray menu, including clear',
    () async {
      final client = _Client();
      final media = FakeWindowsMediaSessionPort();
      final tray = FakeDesktopTrayPort();
      final controller = WindowsDesktopIntegrationController(
        client: client,
        mediaSession: media,
        tray: tray,
        window: FakeDesktopWindowPort(),
        closeBehavior: () => WindowCloseBehavior.exitApplication,
      );
      await controller.initialize();
      final item = _item();
      client.snapshotsController.add(
        _snapshot(
          PlaybackStatus.playing,
          item: item,
          position: const Duration(seconds: 3),
          duration: const Duration(seconds: 20),
        ),
      );
      await Future<void>.delayed(Duration.zero);
      expect(media.states.last, PlaybackStatus.playing);
      expect(media.metadata.last['title'], 'Track A');
      expect(media.timelines.last.position, const Duration(seconds: 3));
      expect(tray.menu, isNotNull);
      expect(tray.menu!.playing, isTrue);
      client.snapshotsController.add(_snapshot(PlaybackStatus.idle));
      await Future<void>.delayed(Duration.zero);
      expect(media.metadata.last['title'], isNull);
      expect(tray.menu!.title, 'MpvPlay');
      await controller.dispose();
      await client.dispose();
    },
  );

  test(
    'initialization failures are swallowed and playback command path remains usable',
    () async {
      final client = _Client();
      final media = FakeWindowsMediaSessionPort()..failInitialize = true;
      final tray = FakeDesktopTrayPort()..failInitialize = true;
      final window = FakeDesktopWindowPort()..failInitialize = true;
      final controller = WindowsDesktopIntegrationController(
        client: client,
        mediaSession: media,
        tray: tray,
        window: window,
        closeBehavior: () => WindowCloseBehavior.exitApplication,
      );
      await expectLater(controller.initialize(), completes);
      media.emit(const WindowsMediaCommand(WindowsMediaCommandType.play));
      await Future<void>.delayed(Duration.zero);
      expect(client.commands.single, isA<Play>());
      await controller.dispose();
      await client.dispose();
    },
  );

  test('close-to-tray hides and keeps playback alive', () async {
    final client = _Client();
    final window = FakeDesktopWindowPort();
    final controller = WindowsDesktopIntegrationController(
      client: client,
      mediaSession: FakeWindowsMediaSessionPort(),
      tray: FakeDesktopTrayPort(),
      window: window,
      closeBehavior: () => WindowCloseBehavior.hideToTray,
    );
    await controller.initialize();
    window.emitClose();
    await Future<void>.delayed(Duration.zero);
    expect(window.hideCount, 1);
    expect(controller.quitting, isFalse);
    await controller.dispose();
    await client.dispose();
  });

  test(
    'tray show/hide and quit are mapped; repeated quit/dispose is idempotent',
    () async {
      final client = _Client();
      final tray = FakeDesktopTrayPort();
      final window = FakeDesktopWindowPort();
      final media = FakeWindowsMediaSessionPort();
      final controller = WindowsDesktopIntegrationController(
        client: client,
        mediaSession: media,
        tray: tray,
        window: window,
        closeBehavior: () => WindowCloseBehavior.hideToTray,
      );
      await controller.initialize();
      tray.emit(const TrayCommand(TrayCommandType.show));
      tray.emit(const TrayCommand(TrayCommandType.hide));
      await Future<void>.delayed(Duration.zero);
      expect(window.showCount, 1);
      expect(window.hideCount, 1);
      tray.emit(const TrayCommand(TrayCommandType.quit));
      await Future<void>.delayed(Duration.zero);
      await controller.quit();
      await controller.dispose();
      expect(controller.quitting, isTrue);
      expect(window.closeCount, 1);
      expect(media.disposed, isTrue);
      expect(tray.disposed, isTrue);
      await client.dispose();
    },
  );

  test(
    'tray command playback controls map to Runtime and failed tray falls back to exit',
    () async {
      final client = _Client();
      final tray = FakeDesktopTrayPort();
      final controller = WindowsDesktopIntegrationController(
        client: client,
        mediaSession: FakeWindowsMediaSessionPort(),
        tray: tray,
        window: FakeDesktopWindowPort(),
        closeBehavior: () => WindowCloseBehavior.hideToTray,
        initialSnapshot: _snapshot(PlaybackStatus.paused),
      );
      await controller.initialize();
      tray.emit(const TrayCommand(TrayCommandType.previous));
      tray.emit(const TrayCommand(TrayCommandType.toggle));
      tray.emit(const TrayCommand(TrayCommandType.next));
      await Future<void>.delayed(Duration.zero);
      expect(client.commands.map((e) => e.runtimeType), [
        SkipPrevious,
        Play,
        SkipNext,
      ]);
      await controller.dispose();
      await client.dispose();

      final fallbackClient = _Client();
      final failingTray = FakeDesktopTrayPort()..failInitialize = true;
      final fallbackWindow = FakeDesktopWindowPort();
      final fallback = WindowsDesktopIntegrationController(
        client: fallbackClient,
        mediaSession: FakeWindowsMediaSessionPort(),
        tray: failingTray,
        window: fallbackWindow,
        closeBehavior: () => WindowCloseBehavior.hideToTray,
      );
      await fallback.initialize();
      fallbackWindow.emitClose();
      await Future<void>.delayed(Duration.zero);
      expect(fallback.quitting, isTrue);
      expect(fallbackWindow.closeAllowed, isTrue);
      await fallbackClient.dispose();
    },
  );

  test(
    'quit races with platform command: command is not sent after quitting begins',
    () async {
      final client = _Client(sendDelay: const Duration(milliseconds: 10));
      final media = FakeWindowsMediaSessionPort();
      final controller = WindowsDesktopIntegrationController(
        client: client,
        mediaSession: media,
        tray: FakeDesktopTrayPort(),
        window: FakeDesktopWindowPort(),
        closeBehavior: () => WindowCloseBehavior.exitApplication,
      );
      await controller.initialize();
      final quitting = controller.quit();
      media.emit(const WindowsMediaCommand(WindowsMediaCommandType.play));
      await quitting;
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(client.commands, isEmpty);
      await client.dispose();
    },
  );
}
