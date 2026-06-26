import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppTabBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  final VoidCallback? onScan;

  const AppTabBar({super.key, required this.index, required this.onTap, this.onScan});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = [
      _TabItemData(Icons.home_outlined, Icons.home_rounded, 'Beranda'),
      _TabItemData(Icons.swap_horiz_rounded, Icons.swap_horiz_rounded, 'Riwayat'),
      _TabItemData(Icons.qr_code_scanner_rounded, Icons.qr_code_scanner_rounded, 'Scan'),
      _TabItemData(Icons.local_offer_outlined, Icons.local_offer_rounded, 'Promo'),
      _TabItemData(Icons.person_outline_rounded, Icons.person_rounded, 'Akun'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white, // Dynamically maps to light/dark surfaces
        border: Border(top: BorderSide(color: AppColors.line, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: SizedBox(
        height: 64,
        child: Row(
          children: items.asMap().entries.map((e) {
            final i = e.key;
            final item = e.value;
            final active = i == index;

            // Center scan button with micro-animations
            if (i == 2) {
              return _AnimatedScanButton(onTap: onScan);
            }

            // Normal tab items with smooth scale and color transitions
            return _AnimatedTabButton(
              onTap: () => onTap(i > 2 ? i - 1 : i),
              icon: item.icon,
              activeIcon: item.activeIcon,
              label: item.label,
              active: active,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TabItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  _TabItemData(this.icon, this.activeIcon, this.label);
}

class _AnimatedTabButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool active;

  const _AnimatedTabButton({
    required this.onTap,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.active,
  });

  @override
  State<_AnimatedTabButton> createState() => _AnimatedTabButtonState();
}

class _AnimatedTabButtonState extends State<_AnimatedTabButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final targetColor = widget.active ? AppColors.primary : AppColors.slate500;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.92 : (widget.active ? 1.05 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              TweenAnimationBuilder<Color?>(
                duration: const Duration(milliseconds: 180),
                tween: ColorTween(
                  begin: AppColors.slate500,
                  end: targetColor,
                ),
                builder: (context, color, child) {
                  return Icon(
                    widget.active ? widget.activeIcon : widget.icon,
                    size: 22,
                    color: color,
                  );
                },
              ),
              const SizedBox(height: 3),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 10.5,
                  fontWeight: widget.active ? FontWeight.w800 : FontWeight.w500,
                  color: targetColor,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                width: widget.active ? 14 : 0,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedScanButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _AnimatedScanButton({this.onTap});

  @override
  State<_AnimatedScanButton> createState() => _AnimatedScanButtonState();
}

class _AnimatedScanButtonState extends State<_AnimatedScanButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: Center(
          child: AnimatedScale(
            scale: _isPressed ? 0.90 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF2C8BFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryDark, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: _isPressed ? 4 : 8,
                    spreadRadius: _isPressed ? 0 : 1,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.qr_code_scanner_rounded, size: 24, color: AppColors.bg),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
