import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/models/cart_item_entity.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:sizer/sizer.dart';

class AddToCartBtns extends StatelessWidget {
  final CartItemEntity cartItem;

  const AddToCartBtns({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int quantity = cartItem.quantity;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(isMobile ? 6.sp : 4.sp),
      decoration: const BoxDecoration(
          // color: Colors.blue,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _quantityBtn(
                  icon: Icons.remove,
                  context: context,
                  onTap: () => _updateCart(quantity - 1, context),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.sp),
                  // width: isMobile ? 0 : 60,
                  child: Text(
                    quantity.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
                      fontSize: isMobile ? sp20 : 18.sp,
                    ),
                  ),
                ),
                _quantityBtn(
                  icon: Icons.add,
                  isFilled: true,
                  context: context,
                  onTap: () => _updateCart(quantity + 1, context),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          FittedBox(
            child: Text(
              "XOF ${formatNumber(cartItem.amount)}",
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 12.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityBtn({
    required IconData icon,
    required Function() onTap,
    required BuildContext context,
    bool isFilled = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final double size = isMobile ? 24.sp : 28.sp;

    return ClickableContainer(
    onTap: onTap,
      // padding: const EdgeInsets.all(2),
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFilled ? colorScheme.primary : null,
        border: Border.all(color: colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 24,
        color: isFilled ? Colors.white : colorScheme.primary,
      ),
    );
  }

  void _updateCart(int value, BuildContext context) {
    if (value < 0) return;

    final result = Provider.of<UserProvider>(context, listen: false).updateCart(
      cartItem.product,
      value,
    );

    if (result == 0) {
      appSnackbar(
        context: context,
        text: "${cartItem.product.label} added to cart",
      );
    } else if (result == -1) {
      appSnackbar(
        context: context,
        text: "${cartItem.product.label} removed from cart",
      );
    }
  }
}
