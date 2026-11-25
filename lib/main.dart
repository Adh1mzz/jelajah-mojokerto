import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/wisata_providers.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

void main() {
  // Soal 4a: Bungkus aplikasi dengan ProviderScope
  runApp(
    const ProviderScope(
      child: JelajahMojokertoApp(),
    ),
  );
}

class JelajahMojokertoApp extends ConsumerWidget {
  const JelajahMojokertoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Soal 4e: Mode terang/gelap berlaku di seluruh halaman melalui themeMode pada MaterialApp
    final ThemeMode themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jelajah Mojokerto - Adhim',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const MainScreen(),
    );
  }
}
