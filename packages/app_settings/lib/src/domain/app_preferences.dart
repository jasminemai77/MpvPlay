import 'app_theme_preference.dart';

final class AppPreferences {
  const AppPreferences({
    this.version = 1,
    this.theme = AppThemePreference.system,
    this.scanOnStartup = false,
    this.scanNewRootsImmediately = true,
  });
  static const defaults = AppPreferences();
  final int version;
  final AppThemePreference theme;
  final bool scanOnStartup;
  final bool scanNewRootsImmediately;
  AppPreferences copyWith({
    AppThemePreference? theme,
    bool? scanOnStartup,
    bool? scanNewRootsImmediately,
  }) => AppPreferences(
    version: version,
    theme: theme ?? this.theme,
    scanOnStartup: scanOnStartup ?? this.scanOnStartup,
    scanNewRootsImmediately:
        scanNewRootsImmediately ?? this.scanNewRootsImmediately,
  );
  Map<String, Object> toJson() => {
    'version': version,
    'theme': theme.name,
    'scanOnStartup': scanOnStartup,
    'scanNewRootsImmediately': scanNewRootsImmediately,
  };
}
