// ignore_for_file: deprecated_member_use

import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../../library/application/library_providers.dart';
import '../application/settings_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Future<void> _addFolder(BuildContext context, WidgetRef ref) async {
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Add music folder',
    );
    if (path == null || !context.mounted) return;
    try {
      await ref.read(libraryControllerProvider).addDirectory(path);
    } catch (error) {
      if (context.mounted) _message(context, '$error');
    }
  }

  Future<void> _disableRoot(
    BuildContext context,
    WidgetRef ref,
    ManagedLibraryRoot root,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disable music folder?'),
        content: const Text(
          'This does not delete files on disk, favorites, playlists, or '
          'playback history. Re-enable and scan this folder to restore tracks.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep enabled'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Disable'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(libraryControllerProvider).setRootEnabled(root.id, false);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences =
        ref.watch(appPreferencesProvider).value ?? AppPreferences.defaults;
    final roots =
        ref.watch(managedLibraryRootsProvider).value ??
        const <ManagedLibraryRoot>[];
    final controller = ref.read(settingsControllerProvider);
    final library = ref.read(libraryControllerProvider);
    final scanning = roots.any(
      (root) =>
          root.scanState == LibraryRootScanState.scanning ||
          root.scanState == LibraryRootScanState.cancelling,
    );
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
          ListTile(
            title: const Text('Music folders'),
            subtitle: const Text('Manage local folders used by the library'),
            trailing: Wrap(
              spacing: 4,
              children: [
                TextButton(
                  onPressed: () => _addFolder(context, ref),
                  child: const Text('Add folder'),
                ),
                TextButton(
                  onPressed: scanning ? null : () => library.scanAll(),
                  child: const Text('Scan all'),
                ),
                if (scanning)
                  TextButton(
                    onPressed: library.cancelScan,
                    child: const Text('Cancel scan'),
                  ),
              ],
            ),
          ),
          if (roots.isEmpty)
            const ListTile(
              leading: Icon(Icons.folder_off_outlined),
              title: Text('No music folders added'),
              subtitle: Text('Add a music folder to build your library.'),
            ),
          for (final root in roots)
            ListTile(
              leading: Icon(
                root.currentlyReachable
                    ? Icons.folder_outlined
                    : Icons.folder_off_outlined,
              ),
              title: Text(root.displayPath),
              subtitle: Text(_rootSummary(root)),
              isThreeLine: root.summary?.message != null,
              trailing: PopupMenuButton<_RootAction>(
                onSelected: (action) async {
                  try {
                    switch (action) {
                      case _RootAction.scan:
                        library.rescan(root.id);
                        break;
                      case _RootAction.enable:
                        await library.setRootEnabled(root.id, true);
                        break;
                      case _RootAction.disable:
                        await _disableRoot(context, ref, root);
                        break;
                    }
                  } catch (error) {
                    if (context.mounted) _message(context, '$error');
                  }
                },
                itemBuilder: (_) => [
                  if (root.enabled && !scanning)
                    const PopupMenuItem(
                      value: _RootAction.scan,
                      child: Text('Scan now'),
                    ),
                  if (root.enabled)
                    const PopupMenuItem(
                      value: _RootAction.disable,
                      child: Text('Disable'),
                    )
                  else
                    const PopupMenuItem(
                      value: _RootAction.enable,
                      child: Text('Enable'),
                    ),
                ],
              ),
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

enum _RootAction { scan, enable, disable }

String _rootSummary(ManagedLibraryRoot root) {
  final state = switch (root.scanState) {
    LibraryRootScanState.disabled => 'Disabled',
    LibraryRootScanState.unavailable => 'Folder unavailable',
    LibraryRootScanState.neverScanned => 'Not scanned yet',
    LibraryRootScanState.scanning => 'Scanning',
    LibraryRootScanState.cancelling => 'Cancelling scan',
    LibraryRootScanState.completed => 'Scan completed',
    LibraryRootScanState.failed => 'Scan failed',
    LibraryRootScanState.cancelled => 'Scan cancelled',
  };
  final result = root.summary;
  if (result == null) return state;
  final details =
      '${result.discoveredCount} files, ${result.missingCount} missing';
  return result.message == null
      ? '$state · $details'
      : '$state · ${result.message}';
}

void _message(BuildContext context, String value) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
}
