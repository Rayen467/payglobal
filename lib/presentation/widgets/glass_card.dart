import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blur;
  final Color color;
  final Color borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.blur = 15,
    this.color = const Color(0x0EFFFFFF), // ~8% opacity white for elegant glass look
    this.borderColor = const Color(0x15FFFFFF), // ~8.2% opacity white border
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!isDark) {
      final cardColor = color == const Color(0x0EFFFFFF) ? const Color(0xFFEDF2F7) : color;
      return Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.6),
            width: 1.0,
          ),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: const Color(0xFFA6B4C9).withValues(alpha: 0.45),
              offset: const Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: padding,
        child: child,
      );
    }

    // Premium frosted glass color mapping for light vs dark mode
    final cardColor = color == const Color(0x0EFFFFFF)
        ? (isDark ? const Color(0x0EFFFFFF) : const Color(0xA0FFFFFF))
        : color;

    final cardBorderColor = borderColor == const Color(0x15FFFFFF)
        ? (isDark ? const Color(0x15FFFFFF) : const Color(0x1A000000))
        : borderColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: cardBorderColor,
              width: 1.2,
            ),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
