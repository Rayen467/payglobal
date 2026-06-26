import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    const fontFamily = 'PlusJakartaSans';
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: AppColors.bg,
        secondary: AppColors.green,
        surface: AppColors.white,
        onSurface: AppColors.ink,
        error: AppColors.red,
      ),
      scaffoldBackgroundColor: AppColors.bg,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF0F1520) : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        iconTheme: const IconThemeData(color: AppColors.ink),
        titleTextStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.bg,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.primaryDark, width: 2.5),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line, width: 2.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line, width: 2.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.5),
        ),
      ),
      dividerColor: AppColors.line2,
      dividerTheme: const DividerThemeData(
        color: AppColors.line2,
        thickness: 1,
      ),
    );
  }

  static ThemeData get light {
    final prev = AppColors.isDarkMode;
    AppColors.isDarkMode = false;
    final theme = _buildTheme(Brightness.light);
    AppColors.isDarkMode = prev;
    return theme;
  }

  static ThemeData get dark {
    final prev = AppColors.isDarkMode;
    AppColors.isDarkMode = true;
    final theme = _buildTheme(Brightness.dark);
    AppColors.isDarkMode = prev;
    return theme;
  }
}
