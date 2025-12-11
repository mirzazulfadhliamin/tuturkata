import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/color_styles.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow,
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () => onItemSelected(0),
            ),
            _NavItem(
              icon: Icons.menu_book_outlined,
              label: 'Exercises',
              isActive: currentIndex == 1,
              onTap: () => onItemSelected(1),
            ),
            _NavItem(
              icon: Icons.trending_up,
              label: 'Progress',
              isActive: currentIndex == 2,
              onTap: () => onItemSelected(2),
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isActive: currentIndex == 3,
              onTap: () => onItemSelected(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColor.primary;
    final Color inactiveColor = AppColor.grayDark.withOpacity(0.6);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? activeColor : inactiveColor,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: tsBodySmallMedium(isActive ? activeColor : inactiveColor),
          ),
        ],
      ),
    );
  }
}