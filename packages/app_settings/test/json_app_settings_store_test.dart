import 'dart:async';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  late File file;
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('mpvplay-settings-');
    file = File('${directory.path}${Platform.pathSeparator}settings.json');
  });
  tearDown(() => directory.delete(recursive: true));
  test('missing file loads defaults and writes durable preferences', () async {
    final store = JsonAppSettingsStore(file);
    await store.load();
    expect(store.current.theme, AppThemePreference.system);
    await store.setTheme(AppThemePreference.dark);
    await store.setScanOnStartup(true);
    final reloaded = JsonAppSettingsStore(file);
    await reloaded.load();
    expect(reloaded.current.theme, AppThemePreference.dark);
    expect(reloaded.current.scanOnStartup, isTrue);
  });
  test('corrupt JSON is backed up and defaults remain usable', () async {
    await file.writeAsString('{bad');
    final failures = <AppSettingsFailure>[];
    final store = JsonAppSettingsStore(file, diagnostics: failures.add);
    await store.load();
    expect(store.current.theme, AppThemePreference.system);
    expect(
      failures.single.code,
      AppSettingsFailureCode.corruptSettingsRecovered,
    );
    expect(
      (await directory.list().toList()).any(
        (e) => e.path.contains('.corrupt-'),
      ),
      isTrue,
    );
  });
  test(
    'unknown values fall back and rapid writes retain last successful value',
    () async {
      await file.writeAsString('{"version":1,"theme":"amoled","unused":3}');
      final store = JsonAppSettingsStore(file);
      await store.load();
      expect(store.current.theme, AppThemePreference.system);
      await Future.wait([
        store.setTheme(AppThemePreference.light),
        store.setTheme(AppThemePreference.dark),
      ]);
      final restored = JsonAppSettingsStore(file);
      await restored.load();
      expect(restored.current.theme, AppThemePreference.dark);
    },
  );

  test('future versions are backed up and reset persists defaults', () async {
    await file.writeAsString('{"version":99,"theme":"dark"}');
    final store = JsonAppSettingsStore(file);
    await store.load();
    expect(store.current.theme, AppThemePreference.system);
    expect(
      (await directory.list().toList()).any(
        (e) => e.path.contains('.corrupt-'),
      ),
      isTrue,
    );
    await store.setTheme(AppThemePreference.dark);
    await store.resetToDefaults();
    final restored = JsonAppSettingsStore(file);
    await restored.load();
    expect(restored.current.theme, AppThemePreference.system);
    expect(restored.current.scanNewRootsImmediately, isTrue);
  });

  test('failed replacement keeps current and watch silent', () async {
    await file.writeAsString(AppPreferences.defaults.toJson().toString());
    // Start with valid JSON so the previous durable value is observable.
    await file.writeAsString('{"version":1,"theme":"light"}');
    final operations = _FailingReplaceOperations();
    final store = JsonAppSettingsStore(file, fileOperations: operations);
    await store.load();
    final changes = <AppPreferences>[];
    final subscription = store.watch().listen(changes.add);

    await expectLater(
      store.setTheme(AppThemePreference.dark),
      throwsA(isA<AppSettingsFailure>()),
    );

    expect(store.current.theme, AppThemePreference.light);
    expect(changes, [isA<AppPreferences>()]);
    expect(await file.readAsString(), '{"version":1,"theme":"light"}');
    await subscription.cancel();
  });

  test('close waits for an in-flight write and then rejects writes', () async {
    final operations = _BlockingOperations();
    final store = JsonAppSettingsStore(file, fileOperations: operations);
    final writing = store.setTheme(AppThemePreference.dark);
    await operations.writeStarted.future;
    var closed = false;
    final closing = store.close().then((_) => closed = true);
    await Future<void>.delayed(Duration.zero);
    expect(closed, isFalse);
    operations.allowWrite.complete();
    await writing;
    await closing;
    await expectLater(
      store.setTheme(AppThemePreference.light),
      throwsA(isA<StateError>()),
    );
  });
}

class _FailingReplaceOperations extends IoAppSettingsFileOperations {
  @override
  Future<void> replace(File temporary, File destination) =>
      Future.error(const FileSystemException('injected replace failure'));
}

class _BlockingOperations extends IoAppSettingsFileOperations {
  final writeStarted = Completer<void>();
  final allowWrite = Completer<void>();

  @override
  Future<void> write(File file, String contents) async {
    writeStarted.complete();
    await allowWrite.future;
    await super.write(file, contents);
  }
}
