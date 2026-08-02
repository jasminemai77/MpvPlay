// ignore_for_file: deprecated_member_use

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/settings_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences =
        ref.watch(appPreferencesProvider).value ?? AppPreferences.defaults;
    final controller = ref.read(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const ListTile(title: Text('Appearance')),
          RadioListTile(
            value: AppThemePreference.system,
            groupValue: preferences.theme,
            title: const Text('System'),
            onChanged: (value) => controller.setTheme(value!),
          ),
          RadioListTile(
            value: AppThemePreference.light,
            groupValue: preferences.theme,
            title: const Text('Light'),
            onChanged: (value) => controller.setTheme(value!),
          ),
          RadioListTile(
            value: AppThemePreference.dark,
            groupValue: preferences.theme,
            title: const Text('Dark'),
            onChanged: (value) => controller.setTheme(value!),
          ),
          const Divider(),
          const ListTile(title: Text('Scanning')),
          SwitchListTile(
            title: const Text('Scan folders on startup'),
            value: preferences.scanOnStartup,
            onChanged: controller.setScanOnStartup,
          ),
          SwitchListTile(
            title: const Text('Scan newly added folders immediately'),
            value: preferences.scanNewRootsImmediately,
            onChanged: controller.setScanNewRootsImmediately,
          ),
          const Divider(),
          const ListTile(
            title: Text('About'),
            subtitle: Text(
              'MpvPlay\nVersion 0.5.0\nWindows desktop music player',
            ),
          ),
        ],
      ),
    );
  }
}
