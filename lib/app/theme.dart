import 'package:flutter/material.dart';

class AppTheme {
  static const forest = Color(0xFF1F5C4A);
  static const mint = Color(0xFFD9EFE6);
  static const warm = Color(0xFFF7F4EE);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          brightness: Brightness.light,
          surface: warm,
        ),
        scaffoldBackgroundColor: warm,
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: mint,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF111614),
      );
}
