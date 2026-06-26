import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SuccessCheck extends StatefulWidget {
  const SuccessCheck({super.key});
  @override
  State<SuccessCheck> createState() => _SuccessCheckState();
}

class _SuccessCheckState extends State<SuccessCheck> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: Opacity(
            opacity: _opacity.value,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greenSurface,
                border: Border.all(color: AppColors.green.withValues(alpha: 0.3), width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.green.withValues(alpha: 0.2),
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.check_rounded, size: 48, color: AppColors.green),
              ),
            ),
          ),
        );
      },
    );
  }
}
