import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../application/app_settings_failure.dart';
import '../application/app_settings_repository.dart';
import '../domain/app_preferences.dart';
import '../domain/app_theme_preference.dart';

/// File-system seam for deterministic durability and recovery tests.
abstract interface class AppSettingsFileOperations {
  Future<bool> exists(File file);
  Future<String> read(File file);
  Future<void> createParentDirectory(File file);
  Future<void> write(File file, String contents);
  Future<void> replace(File temporary, File destination);
  Future<void> rename(File file, String destination);
  Future<void> deleteIfExists(File file);
}

class IoAppSettingsFileOperations implements AppSettingsFileOperations {
  const IoAppSettingsFileOperations();

  @override
  Future<bool> exists(File file) => file.exists();

  @override
  Future<String> read(File file) => file.readAsString();

  @override
  Future<void> createParentDirectory(File file) =>
      file.parent.create(recursive: true);

  @override
  Future<void> write(File file, String contents) =>
      file.writeAsString(contents, flush: true);

  /// Dart's rename replacement is an atomic replace on the supported desktop
  /// filesystems. The old file is not touched before the replacement succeeds.
  @override
  Future<void> replace(File temporary, File destination) =>
      temporary.rename(destination.path);

  @override
  Future<void> rename(File file, String destination) =>
      file.rename(destination);

  @override
  Future<void> deleteIfExists(File file) async {
    if (await file.exists()) await file.delete();
  }
}

/// Versioned, serialized preferences with recoverable corruption handling.
final class JsonAppSettingsStore implements AppSettingsRepository {
  JsonAppSettingsStore(
    this.file, {
    this.diagnostics,
    this.fileOperations = const IoAppSettingsFileOperations(),
  });
  final File file;
  final void Function(AppSettingsFailure failure)? diagnostics;
  final AppSettingsFileOperations fileOperations;
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
    if (!await fileOperations.exists(file)) return;
    try {
      final decoded = jsonDecode(await fileOperations.read(file));
      if (decoded is! Map<String, Object?>) {
        throw const FormatException('Settings root must be an object');
      }
      final version = decoded['version'];
      if (version is! num || version.toInt() > 2) {
        await _recover(
          AppSettingsFailure(
            AppSettingsFailureCode.unsupportedSettingsVersion,
            'Unsupported settings version',
          ),
        );
        return;
      }
      final parsedVersion = version.toInt();
      _current = AppPreferences(
        version: 2,
        theme: _theme(decoded['theme']),
        scanOnStartup: decoded['scanOnStartup'] is bool
            ? decoded['scanOnStartup']! as bool
            : false,
        scanNewRootsImmediately: decoded['scanNewRootsImmediately'] is bool
            ? decoded['scanNewRootsImmediately']! as bool
            : true,
        windowCloseBehavior: _windowCloseBehavior(
          parsedVersion >= 2 ? decoded['windowCloseBehavior'] : null,
        ),
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
  WindowCloseBehavior _windowCloseBehavior(Object? value) => switch (value) {
    'hideToTray' => WindowCloseBehavior.hideToTray,
    _ => WindowCloseBehavior.exitApplication,
  };
  Future<void> _recover(AppSettingsFailure failure) async {
    try {
      if (await fileOperations.exists(file)) {
        await fileOperations.rename(
          file,
          '${file.path}.corrupt-${DateTime.now().toUtc().microsecondsSinceEpoch}',
        );
      }
    } catch (_) {}
    _current = AppPreferences.defaults;
    diagnostics?.call(failure);
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
  Future<void> setWindowCloseBehavior(WindowCloseBehavior value) =>
      _set(_current.copyWith(windowCloseBehavior: value));
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
      await fileOperations.createParentDirectory(file);
      await fileOperations.write(temporary, jsonEncode(next.toJson()));
      jsonDecode(await fileOperations.read(temporary));
      await fileOperations.replace(temporary, file);
      _current = next;
      if (!_closed) _changes.add(next);
    } catch (error) {
      try {
        await fileOperations.deleteIfExists(temporary);
      } catch (_) {}
      final failure = AppSettingsFailure(
        AppSettingsFailureCode.settingsWriteFailure,
        'Unable to save settings',
        cause: error,
      );
      diagnostics?.call(failure);
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
