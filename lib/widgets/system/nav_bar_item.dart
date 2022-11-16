import 'package:flutter/material.dart';
import 'package:responsive_app/utils/ui.dart';

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final bool isActive;

  const NavBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final iconWidget = Icon(
      isActive ? activeIcon ?? icon : icon,
      color: isActive ? primaryColor : Colors.grey,
    );

    final labelWidget = Text(
      label,
      style: TextStyle(
        color: isActive ? primaryColor : Colors.grey,
        fontWeight: isActive ? FontWeight.bold : null,
        fontSize: isMobile ? 10 : 14,
      ),
    );

    if (isMobile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          labelWidget,
        ],
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          iconWidget,
          const SizedBox(width: 8),
          labelWidget,
        ],
      ),
    );
  }
}
