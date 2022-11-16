import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/screens/cart_screen.dart';
import 'package:responsive_app/screens/notifications_screen.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';

class TopBar extends StatelessWidget {
  final String title;

  const TopBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      margin: EdgeInsets.only(
        bottom: 24,
        right: isMobile ? 0 : 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 24 : 36,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (isMobile) {
                Navigator.of(context).pushNamed(NotificationsScreen.routeName);
              } else {
                EventBusController.fireEvent(EventData(
                  cause: EventCause.viewNotifications,
                ));
              }
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {
              if (isMobile) {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              } else {
                EventBusController.fireEvent(EventData(
                  cause: EventCause.viewCart,
                ));
              }
            },
            icon: Icon(
              userProvider.cart.isEmpty
                  ? Icons.shopping_basket_outlined
                  : Icons.shopping_basket,
            ),
          )
        ],
      ),
    );
  }
}
