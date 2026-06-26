import 'package:flutter/material.dart';

class AppColors {
  // ── Primary — Electric Teal (Aurora accent) ──
  static const Color primary = Color(0xFF00D9B5);
  static const Color primaryLight = Color(0xFF33E8CB);
  static const Color primaryDark = Color(0xFF00A88D);
  static const Color primarySurface = Color(0xFF0D2A2A);
  static const Color primaryBorder = Color(0xFF1A4040);

  // ── Semantic ──
  static const Color green = Color(0xFF22C97A);
  static const Color greenSurface = Color(0xFF0D2E1E);
  static const Color amber = Color(0xFFFFB020);
  static const Color amberSurface = Color(0xFF2E2410);
  static const Color red = Color(0xFFFF4D6A);
  static const Color redSurface = Color(0xFF2E0D14);
  static const Color violet = Color(0xFF9B6DFF);
  static const Color violetSurface = Color(0xFF1A0D2E);

  // ── Neutral — Industrial Dark palette ──
  static const Color ink = Color(0xFFE8ECF2);
  static const Color slate600 = Color(0xFF8B95A8);
  static const Color slate500 = Color(0xFF6B7A90);
  static const Color slate400 = Color(0xFF4B5670);
  static const Color slate300 = Color(0xFF2A3348);
  static const Color line = Color(0xFF1E2A3E);
  static const Color line2 = Color(0xFF161F30);
  static const Color bg = Color(0xFF0A0E17);
  static const Color white = Color(0xFF141B2D); // card surface on dark
  static const Color pureWhite = Color(0xFFFFFFFF); // for text that MUST be white

  // ── Aurora Gradient (header / hero) ──
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.45, 1.0],
    colors: [
      Color(0xFF0A1628),  // deep industrial blue
      Color(0xFF0D2236),  // mid dark teal-blue
      Color(0xFF0A2A2A),  // dark teal
    ],
  );

  // ── Aurora Mesh Gradient (decorative overlays) ──
  static const LinearGradient auroraGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.35, 0.7, 1.0],
    colors: [
      Color(0xFF00D9B5),  // teal
      Color(0xFF2C8BFF),  // electric blue
      Color(0xFFFF3D8C),  // magenta
      Color(0xFF9B6DFF),  // violet
    ],
  );

  // ── Neo-Brutalism Shadows (solid offset, zero blur) ──
  static List<BoxShadow> shadowCard = [
    const BoxShadow(
      color: Color(0x3300D9B5),
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(4, 4),
    ),
  ];
  static List<BoxShadow> shadowSoft = [
    const BoxShadow(
      color: Color(0x20000000),
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(3, 3),
    ),
  ];
  static List<BoxShadow> shadowPrimary = [
    const BoxShadow(
      color: Color(0x5500D9B5),
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(4, 4),
    ),
  ];

  // ── Neo-Brutalism border ──
  static Border brutBorder = Border.all(color: const Color(0xFF1E2A3E), width: 2.5);
  static Border brutBorderAccent = Border.all(color: primary, width: 2.5);

  // ── Tone map for FeatureIcon (dark-tinted surfaces + neon icons) ──
  static Map<String, List<Color>> tones = {
    'blue': [const Color(0xFF0D1A2E), const Color(0xFF2C8BFF)],
    'green': [greenSurface, green],
    'amber': [amberSurface, amber],
    'red': [redSurface, red],
    'violet': [violetSurface, violet],
    'slate': [const Color(0xFF141B2D), slate600],
    'teal': [primarySurface, primary],
  };

  static List<Color> tone(String name) => tones[name] ?? tones['teal']!;
}
