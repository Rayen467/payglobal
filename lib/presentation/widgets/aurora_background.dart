import 'package:flutter/material.dart';

/// Reusable Aurora mesh-gradient background overlay.
/// Renders 2-3 radial gradient circles on top of the dark base,
/// creating the "Aurora UI" mesh effect.
class AuroraBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final double opacity;

  const AuroraBackground({
    super.key,
    required this.child,
    this.colors,
    this.opacity = 0.18,
  });

  @override
  Widget build(BuildContext context) {
    final c = colors ??
        [
          const Color(0xFF00D9B5), // teal
          const Color(0xFFFF3D8C), // magenta
          const Color(0xFF2C8BFF), // electric blue
        ];

    return Stack(
      children: [
        child,
        Positioned(
          top: -80,
          right: -60,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [c[0].withValues(alpha: opacity), Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -80,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [c.length > 1 ? c[1].withValues(alpha: opacity * 0.7) : c[0].withValues(alpha: opacity * 0.7), Colors.transparent],
              ),
            ),
          ),
        ),
        if (c.length > 2)
          Positioned(
            top: 120,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [c[2].withValues(alpha: opacity * 0.5), Colors.transparent],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
