import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../application/app_settings_failure.dart';
import '../application/app_settings_repository.dart';
import '../domain/app_preferences.dart';
import '../domain/app_theme_preference.dart';

/// Versioned, serialized preferences with recoverable corruption handling.
final class JsonAppSettingsStore implements AppSettingsRepository {
  JsonAppSettingsStore(this.file, {this._diagnostics});
  final File file;
  final void Function(AppSettingsFailure failure)? _diagnostics;
  final _changes = StreamController<AppPreferences>.broadcast();
  Future<void> _tail = Future.value();
  AppPreferences _current = AppPreferences.defaults;
  bool _closed = false;
  @override
  AppPreferences get current => _current;
  @override
  Stream<AppPreferences> watch() async* {
    yield _current;
    yield* _changes.stream;
  }

  @override
  Future<void> load() async {
    if (!await file.exists()) return;
    try {
      final decoded = jsonDecode(await file.readAsString());
      if (decoded is! Map<String, Object?>) {
        throw const FormatException('Settings root must be an object');
      }
      final version = decoded['version'];
      if (version is! num || version.toInt() > 1) {
        await _recover(
          AppSettingsFailure(
            AppSettingsFailureCode.unsupportedSettingsVersion,
            'Unsupported settings version',
          ),
        );
        return;
      }
      _current = AppPreferences(
        version: 1,
        theme: _theme(decoded['theme']),
        scanOnStartup: decoded['scanOnStartup'] is bool
            ? decoded['scanOnStartup']! as bool
            : false,
        scanNewRootsImmediately: decoded['scanNewRootsImmediately'] is bool
            ? decoded['scanNewRootsImmediately']! as bool
            : true,
      );
    } catch (error) {
      await _recover(
        AppSettingsFailure(
          AppSettingsFailureCode.corruptSettingsRecovered,
          'Recovered corrupt settings',
          cause: error,
        ),
      );
    }
  }

  AppThemePreference _theme(Object? value) => switch (value) {
    'light' => AppThemePreference.light,
    'dark' => AppThemePreference.dark,
    _ => AppThemePreference.system,
  };
  Future<void> _recover(AppSettingsFailure failure) async {
    try {
      if (await file.exists()) {
        await file.rename(
          '${file.path}.corrupt-${DateTime.now().toUtc().microsecondsSinceEpoch}',
        );
      }
    } catch (_) {}
    _current = AppPreferences.defaults;
    _diagnostics?.call(failure);
  }

  @override
  Future<void> setTheme(AppThemePreference value) =>
      _set(_current.copyWith(theme: value));
  @override
  Future<void> setScanOnStartup(bool value) =>
      _set(_current.copyWith(scanOnStartup: value));
  @override
  Future<void> setScanNewRootsImmediately(bool value) =>
      _set(_current.copyWith(scanNewRootsImmediately: value));
  @override
  Future<void> resetToDefaults() => _set(AppPreferences.defaults);
  Future<void> _set(AppPreferences next) {
    if (_closed) return Future.error(StateError('Settings store is closed'));
    final operation = _tail.then((_) => _write(next));
    _tail = operation.catchError((_) {});
    return operation;
  }

  Future<void> _write(AppPreferences next) async {
    final temporary = File('${file.path}.tmp');
    try {
      await file.parent.create(recursive: true);
      await temporary.writeAsString(jsonEncode(next.toJson()), flush: true);
      jsonDecode(await temporary.readAsString());
      await temporary.rename(file.path);
      _current = next;
      if (!_closed) _changes.add(next);
    } catch (error) {
      try {
        if (await temporary.exists()) await temporary.delete();
      } catch (_) {}
      final failure = AppSettingsFailure(
        AppSettingsFailureCode.settingsWriteFailure,
        'Unable to save settings',
        cause: error,
      );
      _diagnostics?.call(failure);
      throw failure;
    }
  }

  @override
  Future<void> close() async {
    _closed = true;
    await _tail;
    await _changes.close();
  }
}
