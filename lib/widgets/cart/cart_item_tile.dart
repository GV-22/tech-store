import 'package:flutter/material.dart';
import 'package:responsive_app/models/cart_item_entity.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/cart/add_to_cart_btns.dart';
import 'package:sizer/sizer.dart';

class CartItemTile extends StatefulWidget {
  final CartItemEntity cartItem;

  const CartItemTile(this.cartItem, {super.key});

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.cartItem.product.id.toString()),
      onDismissed: (direction) {},
      confirmDismiss: (direction) async {
        return false;
      },
      child: Container(
        // height: 100,
        // color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 4.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: borderRadius8sp,
                color: grey100Color,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.cartItem.product.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 8.sp),
                  AddToCartBtns(cartItem: widget.cartItem)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
