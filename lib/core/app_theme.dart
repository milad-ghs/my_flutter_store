import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';
import 'constant.dart';

class AppTheme {
  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColor.primary,
    brightness: Brightness.light,
    primary: AppColor.primary,
    secondary: AppColor.secondary,
    error: AppColor.error,
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      selectedItemColor: AppColor.primary,
    ),
    colorScheme: lightColorScheme,
    primaryColor: lightColorScheme.primary,
    scaffoldBackgroundColor: AppColor.backgroundLight,
    textTheme: GoogleFonts.openSansTextTheme().apply(
      bodyColor: AppColor.textPrimary,
      displayColor: AppColor.textPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
      titleTextStyle: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: lightColorScheme.onPrimary,
        letterSpacing: 1.0,
      ),
    ),
    cardColor: AppColor.backgroundMedium,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
      ),
    ),
  );

  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColor.primary,
    brightness: Brightness.dark,
    primary: AppColor.primary,
    secondary: AppColor.secondary,
    error: AppColor.error,
  );

  static final ThemeData dark = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Colors.white,
    ),
    useMaterial3: true,
    colorScheme: darkColorScheme,
    primaryColor: darkColorScheme.primary,
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: GoogleFonts.openSansTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF282828),
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardColor: const Color(0xFF1E1E1E),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
      ),
    ),
  );
}
