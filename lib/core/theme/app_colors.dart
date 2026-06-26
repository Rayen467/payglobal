import 'package:flutter/material.dart';

class DynamicColor extends Color {
  final Color lightColor;
  final Color darkColor;

  const DynamicColor(this.lightColor, this.darkColor) : super(0);

  @override
  int get value => AppColors.isDarkMode ? darkColor.value : lightColor.value;
}

class AppColors {
  static bool isDarkMode = true;

  // ── Primary — Electric Teal (Aurora accent) ──
  static const Color primary = Color(0xFF00D9B5);
  static const Color primaryLight = Color(0xFF33E8CB);
  static const Color primaryDark = Color(0xFF00A88D);
  static const Color primarySurface = DynamicColor(
    Color(0xFFE6FBF8), // Light primary surface
    Color(0xFF0D2A2A), // Dark primary surface
  );
  static const Color primaryBorder = DynamicColor(
    Color(0xFFB3F5EB),
    Color(0xFF1A4040),
  );

  // ── Semantic ──
  static const Color green = Color(0xFF22C97A);
  static const Color greenSurface = DynamicColor(
    Color(0xFFE6F9F0),
    Color(0xFF0D2E1E),
  );
  static const Color amber = Color(0xFFFFB020);
  static const Color amberSurface = DynamicColor(
    Color(0xFFFFF7E6),
    Color(0xFF2E2410),
  );
  static const Color red = Color(0xFFFF4D6A);
  static const Color redSurface = DynamicColor(
    Color(0xFFFFECEF),
    Color(0xFF2E0D14),
  );
  static const Color violet = Color(0xFF9B6DFF);
  static const Color violetSurface = DynamicColor(
    Color(0xFFF2ECFF),
    Color(0xFF1A0D2E),
  );

  // ── Neutral — Industrial Dark/Clean Light palette ──
  static const Color ink = DynamicColor(
    Color(0xFF0F172A), // dark slate text on light mode
    Color(0xFFE8ECF2), // light gray text on dark mode
  );
  static const Color slate600 = DynamicColor(
    Color(0xFF475569),
    Color(0xFF8B95A8),
  );
  static const Color slate500 = DynamicColor(
    Color(0xFF64748B),
    Color(0xFF6B7A90),
  );
  static const Color slate400 = DynamicColor(
    Color(0xFF94A3B8),
    Color(0xFF4B5670),
  );
  static const Color slate300 = DynamicColor(
    Color(0xFFCBD5E1),
    Color(0xFF2A3348),
  );
  static const Color line = DynamicColor(
    Color(0xFFE2E8F0),
    Color(0xFF1E2A3E),
  );
  static const Color line2 = DynamicColor(
    Color(0xFFF1F5F9),
    Color(0xFF161F30),
  );
  static const Color bg = DynamicColor(
    Color(0xFFF8FAFC), // very clean light gray bg
    Color(0xFF0A0E17), // deep dark bg
  );
  static const Color white = DynamicColor(
    Color(0xFFFFFFFF), // pure white card surface on light mode
    Color(0xFF141B2D), // dark card surface on dark mode
  );
  static const Color pureWhite = Color(0xFFFFFFFF); // for text that MUST be white

  // ── Aurora Gradient (header / hero) ──
  static LinearGradient get primaryGradient => isDarkMode
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.45, 1.0],
          colors: [
            Color(0xFF0A1628),  // deep industrial blue
            Color(0xFF0D2236),  // mid dark teal-blue
            Color(0xFF0A2A2A),  // dark teal
          ],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.45, 1.0],
          colors: [
            Color(0xFFD4F5EF),  // soft light teal
            Color(0xFFE0EFFF),  // soft light blue
            Color(0xFFF8FAFC),  // soft light background color
          ],
        );

  // ── Aurora Mesh Gradient (decorative overlays) ──
  static LinearGradient get auroraGradient => isDarkMode
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.35, 0.7, 1.0],
          colors: [
            Color(0xFF00D9B5),  // teal
            Color(0xFF2C8BFF),  // electric blue
            Color(0xFFFF3D8C),  // magenta
            Color(0xFF9B6DFF),  // violet
          ],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.35, 0.7, 1.0],
          colors: [
            Color(0xFF8FF2E2),  // soft teal
            Color(0xFF94C4FF),  // soft blue
            Color(0xFFFF94BF),  // soft pink/magenta
            Color(0xFFC7B0FF),  // soft violet
          ],
        );

  // ── Neo-Brutalism Shadows (solid offset, zero blur) ──
  static List<BoxShadow> get shadowCard => [
        BoxShadow(
          color: isDarkMode ? const Color(0x3300D9B5) : const Color(0x1F00D9B5),
          blurRadius: 0,
          spreadRadius: 0,
          offset: const Offset(4, 4),
        ),
      ];
  static List<BoxShadow> get shadowSoft => [
        BoxShadow(
          color: isDarkMode ? const Color(0x20000000) : const Color(0x0A000000),
          blurRadius: 0,
          spreadRadius: 0,
          offset: const Offset(3, 3),
        ),
      ];
  static List<BoxShadow> get shadowPrimary => [
        BoxShadow(
          color: isDarkMode ? const Color(0x5500D9B5) : const Color(0x2500D9B5),
          blurRadius: 0,
          spreadRadius: 0,
          offset: const Offset(4, 4),
        ),
      ];

  // ── Neo-Brutalism border ──
  static Border get brutBorder => Border.all(color: line, width: 2.5);
  static Border get brutBorderAccent => Border.all(color: primary, width: 2.5);

  // ── Tone map for FeatureIcon (dark-tinted surfaces + neon icons) ──
  static Map<String, List<Color>> get tones => {
        'blue': isDarkMode
            ? [const Color(0xFF0D1A2E), const Color(0xFF2C8BFF)]
            : [const Color(0xFFE6F0FF), const Color(0xFF2C8BFF)],
        'green': [greenSurface, green],
        'amber': [amberSurface, amber],
        'red': [redSurface, red],
        'violet': [violetSurface, violet],
        'slate': isDarkMode
            ? [const Color(0xFF141B2D), slate600]
            : [const Color(0xFFF1F5F9), slate600],
        'teal': [primarySurface, primary],
      };

  static List<Color> tone(String name) => tones[name] ?? tones['teal']!;
}
