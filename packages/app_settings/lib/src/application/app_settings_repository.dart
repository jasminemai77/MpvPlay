import '../domain/app_preferences.dart';
import '../domain/app_theme_preference.dart';

abstract interface class AppSettingsRepository {
  AppPreferences get current;
  Stream<AppPreferences> watch();
  Future<void> load();
  Future<void> setTheme(AppThemePreference theme);
  Future<void> setScanOnStartup(bool enabled);
  Future<void> setScanNewRootsImmediately(bool enabled);
  Future<void> setWindowCloseBehavior(WindowCloseBehavior behavior);
  Future<void> resetToDefaults();
  Future<void> close();
}
