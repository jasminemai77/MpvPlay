import 'dart:async';

import 'package:platform_bridge/platform_bridge.dart';
import 'package:tray_manager/tray_manager.dart';

final class TrayManagerDesktopTrayAdapter
    with TrayListener
    implements DesktopTrayPort {
  final _commands = StreamController<TrayCommand>.broadcast();
  @override
  Stream<TrayCommand> get commands => _commands.stream;
  @override
  Future<void> initialize() async {
    trayManager.addListener(this);
    await trayManager.setIcon('windows/runner/resources/app_icon.ico');
    await updateMenu(const TrayMenuState());
  }

  @override
  Future<void> updateMenu(TrayMenuState state) => trayManager.setContextMenu(
    Menu(
      items: [
        MenuItem(label: state.title, disabled: true),
        MenuItem.separator(),
        MenuItem(key: 'show', label: 'Show'),
        MenuItem(key: 'hide', label: 'Hide'),
        MenuItem(key: 'previous', label: 'Previous'),
        MenuItem(key: 'toggle', label: state.playing ? 'Pause' : 'Play'),
        MenuItem(key: 'next', label: 'Next'),
        MenuItem.separator(),
        MenuItem(key: 'quit', label: 'Quit'),
      ],
    ),
  );
  @override
  Future<void> updateTooltip(String value) => trayManager.setToolTip(value);
  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    final type = switch (menuItem.key) {
      'show' => TrayCommandType.show,
      'hide' => TrayCommandType.hide,
      'previous' => TrayCommandType.previous,
      'toggle' => TrayCommandType.toggle,
      'next' => TrayCommandType.next,
      'quit' => TrayCommandType.quit,
      _ => null,
    };
    if (type != null) _commands.add(TrayCommand(type));
  }

  @override
  Future<void> dispose() async {
    trayManager.removeListener(this);
    await trayManager.destroy();
    await _commands.close();
  }
}
