import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final double size;
  final Color? bg;

  const AppAvatar({super.key, required this.name, this.size = 48, this.bg});

  static const _neonPalette = [
    Color(0xFF00D9B5),
    Color(0xFF2C8BFF),
    Color(0xFFFF3D8C),
    Color(0xFF9B6DFF),
    Color(0xFFFFB020),
    Color(0xFF22C97A),
  ];

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final colorIdx = name.codeUnits.fold(0, (a, b) => a + b) % _neonPalette.length;
    final color = _neonPalette[colorIdx];
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg ?? color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size * 0.32),
        border: Border.all(color: bg ?? color.withValues(alpha: 0.4), width: 2),
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: size * 0.38,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ),
    );
  }
}
