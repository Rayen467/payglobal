import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppTabBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  final VoidCallback? onScan;

  const AppTabBar({super.key, required this.index, required this.onTap, this.onScan});

  @override
  Widget build(BuildContext context) {
    final items = [
      _TabItem(Icons.home_outlined, Icons.home_rounded, 'Beranda'),
      _TabItem(Icons.swap_horiz_rounded, Icons.swap_horiz_rounded, 'Riwayat'),
      _TabItem(Icons.qr_code_scanner_rounded, Icons.qr_code_scanner_rounded, 'Scan'),
      _TabItem(Icons.local_offer_outlined, Icons.local_offer_rounded, 'Promo'),
      _TabItem(Icons.person_outline_rounded, Icons.person_rounded, 'Akun'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1520),
        border: const Border(top: BorderSide(color: AppColors.line, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: SizedBox(
        height: 62,
        child: Row(
          children: items.asMap().entries.map((e) {
            final i = e.key;
            final item = e.value;
            final active = i == index;

            // Scan button — center with Aurora gradient
            if (i == 2) {
              return Expanded(
                child: GestureDetector(
                  onTap: onScan,
                  child: Center(
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, Color(0xFF2C8BFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryDark, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.35),
                            blurRadius: 0,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.qr_code_scanner_rounded, size: 26, color: AppColors.bg),
                      ),
                    ),
                  ),
                ),
              );
            }

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i > 2 ? i - 1 : i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      active ? item.activeIcon : item.icon,
                      size: 24,
                      color: active ? AppColors.primary : AppColors.slate500,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                        color: active ? AppColors.primary : AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  _TabItem(this.icon, this.activeIcon, this.label);
}
