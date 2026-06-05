import 'package:flutter/material.dart';
import 'package:sadegh/core/theme/app_theme.dart';




class AppTheme {

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff386A20),
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

}
