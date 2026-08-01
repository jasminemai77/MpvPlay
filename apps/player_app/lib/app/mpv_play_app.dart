import 'package:flutter/material.dart';
import '../features/now_playing/presentation/player_page.dart';

class MpvPlayApp extends StatelessWidget {
  const MpvPlayApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MpvPlay',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff6750a4),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    ),
    home: const PlayerPage(),
  );
}
