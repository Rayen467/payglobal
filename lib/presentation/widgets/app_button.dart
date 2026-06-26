import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum AppButtonVariant { primary, soft, outline }

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool fullWidth;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.fullWidth = true,
    this.icon,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onPressed == null || widget.isLoading;

    // Neo-Brutalism color sets per variant
    Color bg, fg, borderColor;
    List<BoxShadow> shadow;
    switch (widget.variant) {
      case AppButtonVariant.soft:
        bg = AppColors.primarySurface;
        fg = AppColors.primary;
        borderColor = AppColors.primaryBorder;
        shadow = [const BoxShadow(color: Color(0x2000D9B5), offset: Offset(3, 3))];
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = AppColors.ink;
        borderColor = AppColors.line;
        shadow = [const BoxShadow(color: Color(0x15000000), offset: Offset(3, 3))];
      default:
        bg = AppColors.primary;
        fg = AppColors.bg;
        borderColor = AppColors.primaryDark;
        shadow = AppColors.shadowPrimary;
    }

    if (disabled) {
      bg = bg.withValues(alpha: 0.4);
      shadow = [];
    }

    return GestureDetector(
      onTapDown: disabled ? null : (_) => setState(() => _pressed = true),
      onTapUp: disabled ? null : (_) { setState(() => _pressed = false); widget.onPressed?.call(); },
      onTapCancel: disabled ? null : () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.fullWidth ? double.infinity : null,
          height: 54,
          padding: widget.fullWidth ? null : const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 2.5),
            boxShadow: _pressed ? [] : shadow,
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation(fg),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[widget.icon!, const SizedBox(width: 8)],
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: fg,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
