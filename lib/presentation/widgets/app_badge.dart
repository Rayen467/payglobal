import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final String tone;
  const AppBadge({super.key, required this.label, this.tone = 'teal'});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: colors[1].withValues(alpha: 0.3), width: 1.2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          color: colors[1],
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
