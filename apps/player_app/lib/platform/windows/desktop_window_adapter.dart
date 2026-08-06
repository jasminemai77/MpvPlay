import 'dart:async';

import 'package:platform_bridge/platform_bridge.dart';
import 'package:window_manager/window_manager.dart';

final class WindowManagerDesktopWindowAdapter
    with WindowListener
    implements DesktopWindowPort {
  final _closeRequests = StreamController<WindowCloseRequest>.broadcast();
  bool _initialized = false;

  @override
  Stream<WindowCloseRequest> get closeRequests => _closeRequests.stream;
  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await windowManager.ensureInitialized();
    await windowManager.setPreventClose(true);
    windowManager.addListener(this);
  }

  @override
  void onWindowClose() => _closeRequests.add(const WindowCloseRequest());
  @override
  Future<void> showAndActivate() async {
    await windowManager.show();
    await windowManager.focus();
  }

  @override
  Future<void> hide() => windowManager.hide();
  @override
  Future<void> allowClose() => windowManager.setPreventClose(false);
  @override
  Future<void> close() => windowManager.close();
  @override
  Future<void> dispose() async {
    windowManager.removeListener(this);
    await _closeRequests.close();
  }
}
