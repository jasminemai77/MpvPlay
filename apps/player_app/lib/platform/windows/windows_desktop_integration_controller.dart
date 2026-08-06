import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:platform_bridge/platform_bridge.dart';

final class WindowsDesktopIntegrationController {
  WindowsDesktopIntegrationController({
    required this.client,
    required this.mediaSession,
    required this.tray,
    required this.window,
    required this.closeBehavior,
    this.initialSnapshot,
  });

  final PlaybackClient client;
  final WindowsMediaSessionPort mediaSession;
  final DesktopTrayPort tray;
  final DesktopWindowPort window;
  final WindowCloseBehavior Function() closeBehavior;
  final PlaybackSnapshot? initialSnapshot;
  late PlaybackSnapshot _lastSnapshot = initialSnapshot ?? _idleSnapshot;

  StreamSubscription<WindowsMediaCommand>? _mediaSubscription;
  StreamSubscription<TrayCommand>? _traySubscription;
  StreamSubscription<WindowCloseRequest>? _closeSubscription;
  StreamSubscription<PlaybackSnapshot>? _snapshotSubscription;
  bool initialized = false;
  bool quitting = false;
  bool _disposed = false;
  bool _mediaAvailable = false;
  bool _trayAvailable = false;
  bool _windowAvailable = false;
  Future<void>? _quitting;

  Future<void> initialize() async {
    if (initialized || _disposed) return;
    initialized = true;
    _mediaAvailable = await _initializeSafely(mediaSession.initialize);
    _trayAvailable = await _initializeSafely(tray.initialize);
    _windowAvailable = await _initializeSafely(window.initialize);
    _mediaSubscription = mediaSession.commands.listen(_onMediaCommand);
    _traySubscription = tray.commands.listen(_onTrayCommand);
    _closeSubscription = window.closeRequests.listen(_onCloseRequest);
    _snapshotSubscription = client.snapshots.listen(_onSnapshot);
    await _onSnapshot(_lastSnapshot);
  }

  static PlaybackSnapshot get _idleSnapshot => PlaybackSnapshot(
    sessionId: '',
    revision: 0,
    status: PlaybackStatus.idle,
    currentItem: null,
    position: Duration.zero,
    duration: Duration.zero,
    queueItems: const [],
    currentIndex: -1,
    volume: 1,
    muted: false,
    failure: null,
  );

  Future<bool> _initializeSafely(Future<void> Function() action) async {
    try {
      await action();
      return true;
    } catch (_) {
      // Native integration is optional; playback remains usable if a plugin
      // cannot initialize on this machine.
      return false;
    }
  }

  Future<void> _onMediaCommand(WindowsMediaCommand command) async {
    if (quitting) return;
    final now = DateTime.now();
    final session = _sessionId;
    final PlaybackCommand? mapped = switch (command.type) {
      WindowsMediaCommandType.play => Play(
        commandId: 'smtc-play',
        sessionId: session,
        issuedAt: now,
      ),
      WindowsMediaCommandType.pause => Pause(
        commandId: 'smtc-pause',
        sessionId: session,
        issuedAt: now,
      ),
      WindowsMediaCommandType.toggle =>
        _lastSnapshot.status == PlaybackStatus.playing
            ? Pause(
                commandId: 'smtc-toggle-pause',
                sessionId: session,
                issuedAt: now,
              )
            : Play(
                commandId: 'smtc-toggle-play',
                sessionId: session,
                issuedAt: now,
              ),
      WindowsMediaCommandType.previous => SkipPrevious(
        commandId: 'smtc-previous',
        sessionId: session,
        issuedAt: now,
      ),
      WindowsMediaCommandType.next => SkipNext(
        commandId: 'smtc-next',
        sessionId: session,
        issuedAt: now,
      ),
      WindowsMediaCommandType.stop => Stop(
        commandId: 'smtc-stop',
        sessionId: session,
        issuedAt: now,
      ),
      WindowsMediaCommandType.seek =>
        command.position == null
            ? null
            : Seek(
                commandId: 'smtc-seek',
                sessionId: session,
                issuedAt: now,
                position: command.position!,
              ),
    };
    if (mapped != null) await _send(mapped);
  }

  PlaybackCommand _toggleCommand(String session, DateTime now) =>
      _lastSnapshot.status == PlaybackStatus.playing
      ? Pause(commandId: 'tray-toggle-pause', sessionId: session, issuedAt: now)
      : Play(commandId: 'tray-toggle-play', sessionId: session, issuedAt: now);

  Future<void> _onTrayCommand(TrayCommand command) async {
    if (quitting) return;
    final now = DateTime.now();
    switch (command.type) {
      case TrayCommandType.show:
        await window.showAndActivate();
      case TrayCommandType.hide:
        await window.hide();
      case TrayCommandType.previous:
        await _send(
          SkipPrevious(
            commandId: 'tray-previous',
            sessionId: _sessionId,
            issuedAt: now,
          ),
        );
      case TrayCommandType.toggle:
        await _send(_toggleCommand(_sessionId, now));
      case TrayCommandType.next:
        await _send(
          SkipNext(
            commandId: 'tray-next',
            sessionId: _sessionId,
            issuedAt: now,
          ),
        );
      case TrayCommandType.quit:
        await quit();
    }
  }

  Future<void> _onCloseRequest(WindowCloseRequest request) async {
    if (quitting) return;
    if (closeBehavior() == WindowCloseBehavior.hideToTray &&
        _trayAvailable &&
        _windowAvailable) {
      await window.hide();
    } else {
      await quit();
    }
  }

  Future<void> _onSnapshot(PlaybackSnapshot snapshot) async {
    if (_disposed) return;
    _lastSnapshot = snapshot;
    if (_mediaAvailable) {
      try {
        await mediaSession.updatePlaybackState(snapshot.status);
        final item = snapshot.currentItem;
        if (item == null) {
          await mediaSession.clearMetadata();
        } else {
          await mediaSession.updateMetadata(
            title: item.title,
            artist: item.artist,
            album: null,
            artwork: null,
          );
        }
        await mediaSession.updateTimeline(
          position: snapshot.position,
          duration: snapshot.duration,
        );
      } catch (_) {
        _mediaAvailable = false;
      }
    }
    if (_trayAvailable) {
      try {
        final item = snapshot.currentItem;
        await tray.updateMenu(
          TrayMenuState(
            title: item?.title ?? 'MpvPlay',
            playing: snapshot.status == PlaybackStatus.playing,
          ),
        );
      } catch (_) {
        _trayAvailable = false;
      }
    }
  }

  String get _sessionId => _lastSnapshot.sessionId.isEmpty
      ? 'windows-integration'
      : _lastSnapshot.sessionId;

  Future<void> _send(PlaybackCommand command) async {
    try {
      await client.send(command);
    } catch (_) {}
  }

  Future<void> quit() => _quitting ??= _quit();

  Future<void> _quit() async {
    quitting = true;
    _disposed = true;
    await _mediaSubscription?.cancel();
    await _traySubscription?.cancel();
    await _closeSubscription?.cancel();
    await _snapshotSubscription?.cancel();
    if (_windowAvailable) {
      await _ignoreFailure(window.allowClose);
    }
    if (_trayAvailable) await _ignoreFailure(tray.dispose);
    if (_mediaAvailable) await _ignoreFailure(mediaSession.dispose);
    if (_windowAvailable) {
      await _ignoreFailure(window.close);
      await _ignoreFailure(window.dispose);
    }
  }

  Future<void> _ignoreFailure(Future<void> Function() action) async {
    try {
      await action();
    } catch (_) {}
  }

  Future<void> dispose() async => quit();
}
