import 'dart:async';

import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/system/nav_bar_item.dart';

class NavBar extends StatefulWidget {
  final Function(int) onChange;

  const NavBar({required this.onChange, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<NavBarItem> _items = [
    const NavBarItem(
      icon: Icons.home_filled,
      label: "Home",
    ),
    const NavBarItem(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: "Favorites",
    ),
    const NavBarItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: "Orders",
    ),
    const NavBarItem(
      icon: Icons.account_circle_outlined,
      activeIcon: Icons.account_circle,
      label: "Profil",
    ),
  ];

  final List<Widget> _navBarItems = [];
  int _currentIndex = 0;
  late StreamSubscription<EventData> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = EventBusController.eventBus.on<EventData>().listen((event) {
      _listenerHandler(event);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenerHandler(EventData event) {
    // print("EVENT $event");
    switch (event.cause) {
      case EventCause.openSpecificBoard:
        final data = event.data;
        if (data is! int) {
          throw ArgumentError(
              "Invalid data provided to view product details. => $data");
        }
        _updateCurrentMenu(data);
        break;

      default:
        return;
    }
  }

  void _updateCurrentMenu(int index) {
    setState(() => _currentIndex = index);
    widget.onChange(index);
  }

  @override
  Widget build(BuildContext context) {
    // FIXME
    _navBarItems.clear();
    for (var i = 0; i < _items.length; i++) {
      final navItem = _items[i];
      _navBarItems.add(
        ClickableSizedBox(
          onTap: () => _updateCurrentMenu(i),
          child: NavBarItem(
            icon: navItem.icon,
            activeIcon: navItem.activeIcon,
            label: navItem.label,
            isActive: _currentIndex == i,
          ),
        ),
      );
    }

    if (isMobile) {
      return Container(
        height: kBottomNavigationBarHeight,
        decoration: const BoxDecoration(
          // color: Colors.red,
          border: Border(top: BorderSide(width: .7, color: grey400Color)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _navBarItems,
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(width: .5, color: grey400Color)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              borderRadius: borderRadius8sp,
              color: grey100Color,
            ),
          ),
          ..._navBarItems
        ],
      ),
    );
  }
}
