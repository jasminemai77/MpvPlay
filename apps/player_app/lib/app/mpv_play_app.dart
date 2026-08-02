import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/now_playing/presentation/player_page.dart';
import '../features/settings/application/settings_providers.dart';

class MpvPlayApp extends ConsumerWidget {
  const MpvPlayApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preference =
        ref.watch(appPreferencesProvider).value?.theme ??
        AppThemePreference.system;
    final mode = switch (preference) {
      AppThemePreference.light => ThemeMode.light,
      AppThemePreference.dark => ThemeMode.dark,
      AppThemePreference.system => ThemeMode.system,
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MpvPlay',
      themeMode: mode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6750a4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6750a4),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const PlayerPage(),
    );
  }
}
