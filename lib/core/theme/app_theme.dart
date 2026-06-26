import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

  static ThemeData _buildTheme(Brightness brightness) {
    const fontFamily = 'PlusJakartaSans';
    final isDark = brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0A0E17) : const Color(0xFFEDF2F7);
    final cardColor = isDark ? const Color(0xFF141B2D) : const Color(0xFFEDF2F7);
    final textColor = isDark ? const Color(0xFFE8ECF2) : const Color(0xFF0F172A);
    final lineColor = isDark ? const Color(0xFF1E2A3E) : const Color(0xFFE2E8F0);
    final line2Color = isDark ? const Color(0xFF161F30) : const Color(0xFFF1F5F9);

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: isDark ? const Color(0xFF0A0E17) : const Color(0xFFEDF2F7),
        secondary: AppColors.green,
        surface: cardColor,
        onSurface: textColor,
        error: AppColors.red,
      ),
      scaffoldBackgroundColor: bgColor,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF0F1520) : const Color(0xFFEDF2F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: isDark ? const Color(0xFF0A0E17) : const Color(0xFFEDF2F7),
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: isDark ? AppColors.primaryDark : Colors.transparent,
              width: isDark ? 2.5 : 0.0,
            ),
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
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark ? lineColor : lineColor.withValues(alpha: 0.5),
            width: isDark ? 2.5 : 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark ? lineColor : lineColor.withValues(alpha: 0.5),
            width: isDark ? 2.5 : 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: isDark ? 2.5 : 1.5,
          ),
        ),
      ),
      dividerColor: line2Color,
      dividerTheme: DividerThemeData(
        color: line2Color,
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
