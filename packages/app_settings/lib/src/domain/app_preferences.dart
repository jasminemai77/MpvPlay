import 'app_theme_preference.dart';

enum WindowCloseBehavior { exitApplication, hideToTray }

final class AppPreferences {
  const AppPreferences({
    this.version = 2,
    this.theme = AppThemePreference.system,
    this.scanOnStartup = false,
    this.scanNewRootsImmediately = true,
    this.windowCloseBehavior = WindowCloseBehavior.exitApplication,
  });
  static const defaults = AppPreferences();
  final int version;
  final AppThemePreference theme;
  final bool scanOnStartup;
  final bool scanNewRootsImmediately;
  final WindowCloseBehavior windowCloseBehavior;
  AppPreferences copyWith({
    AppThemePreference? theme,
    bool? scanOnStartup,
    bool? scanNewRootsImmediately,
    WindowCloseBehavior? windowCloseBehavior,
  }) => AppPreferences(
    version: version,
    theme: theme ?? this.theme,
    scanOnStartup: scanOnStartup ?? this.scanOnStartup,
    scanNewRootsImmediately:
        scanNewRootsImmediately ?? this.scanNewRootsImmediately,
    windowCloseBehavior: windowCloseBehavior ?? this.windowCloseBehavior,
  );
  Map<String, Object> toJson() => {
    'version': version,
    'theme': theme.name,
    'scanOnStartup': scanOnStartup,
    'scanNewRootsImmediately': scanNewRootsImmediately,
    'windowCloseBehavior': windowCloseBehavior.name,
  };
}
