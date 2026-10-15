import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/app_state.dart';
import 'router.dart';
import 'theme.dart';

class LifeRiseApp extends ConsumerWidget {
  const LifeRiseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(appStateProvider);
    return MaterialApp.router(
      title: 'LifeRise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: prefs.darkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
