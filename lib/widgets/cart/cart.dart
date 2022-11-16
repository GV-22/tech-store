import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/screens/checkout_screen.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/cart/cart_item_tile.dart';
import 'package:responsive_app/widgets/system/fill_btn.dart';
import 'package:sizer/sizer.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final cart = userProvider.cart;

    if (cart.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.shopping_basket_outlined, size: 50),
            SizedBox(height: 24),
            Text("Your cart is empty!")
          ],
        ),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItemTile(cart[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total"),
                Text(
                  "XOF ${formatNumber(userProvider.cartAmount())}",
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          FillBtn(
            label: "Order now",
            onPressed: () {
              if (isMobile) {
                Navigator.of(context).pushNamed(CheckoutScreen.routeName);
              } else {
                EventBusController.fireEvent(EventData(
                  cause: EventCause.viewCheckout,
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
