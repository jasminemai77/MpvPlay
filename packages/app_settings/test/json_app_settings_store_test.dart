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
}
