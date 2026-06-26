import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String tone;
  final double size;
  final double iconSize;

  const FeatureIcon({
    super.key,
    required this.icon,
    this.tone = 'teal',
    this.size = 48,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(size * 0.32),
        border: Border.all(color: colors[1].withValues(alpha: 0.25), width: 1.8),
      ),
      child: Center(
        child: Icon(icon, size: iconSize, color: colors[1]),
      ),
    );
  }
}

/// Custom icon data for DKG-specific icons
class DkgIcons {
  static const IconData arrowLeft = Icons.arrow_back_ios_new_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData copy = Icons.copy_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData mail = Icons.mail_outline_rounded;
  static const IconData shieldCheck = Icons.verified_user_outlined;
  static const IconData smartphone = Icons.smartphone_rounded;
  static const IconData bell = Icons.notifications_outlined;
  static const IconData info = Icons.info_outline_rounded;
  static const IconData lock = Icons.lock_outline_rounded;
  static const IconData eye = Icons.visibility_outlined;
  static const IconData eyeOff = Icons.visibility_off_outlined;
  static const IconData user = Icons.person_outline_rounded;
}
