import 'package:app_settings/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appSettingsRepositoryProvider = Provider<AppSettingsRepository>(
  (_) => throw UnimplementedError(),
);
final appPreferencesProvider = StreamProvider<AppPreferences>(
  (ref) => ref.watch(appSettingsRepositoryProvider).watch(),
);
final settingsControllerProvider = Provider<SettingsController>(
  (ref) => SettingsController(ref.watch(appSettingsRepositoryProvider)),
);

final class SettingsController {
  SettingsController(this._repository);
  final AppSettingsRepository _repository;
  Future<void> setTheme(AppThemePreference value) =>
      _repository.setTheme(value);
  Future<void> setScanOnStartup(bool value) =>
      _repository.setScanOnStartup(value);
  Future<void> setScanNewRootsImmediately(bool value) =>
      _repository.setScanNewRootsImmediately(value);
  Future<void> setWindowCloseBehavior(WindowCloseBehavior value) =>
      _repository.setWindowCloseBehavior(value);
  Future<void> reset() => _repository.resetToDefaults();
}
