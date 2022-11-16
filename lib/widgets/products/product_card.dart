import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/screens/product_details_screen.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/products/rating.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    // final rating = product.rating;
    return ClickableColumn(
      onTap: () {
        if (isMobile) {
          Navigator.of(context).pushNamed(
            ProductDetailsScreen.routeName,
            arguments: product,
          );
        } else {
          EventBusController.fireEvent(
            EventData(cause: EventCause.viewProductDetails, data: product),
          );
        }
      },
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(bottom: 6.sp),
            decoration: BoxDecoration(
              color: grey100Color,
              borderRadius: borderRadius8sp,
            ),
          ),
        ),
        Text(
          product.label,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          product.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: grey400Color,
            fontSize: isMobile ? 10 : 14,
          ),
        ),
        SizedBox(height: 3.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FittedBox(
                child: Text(
                  "XOF ${formatNumber(product.price)}",
                  style: TextStyle(fontSize: isMobile ? 12 : 18),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6.sp),
              child: RatingValue(product.rating),
            )
          ],
        ),
      ],
    );
  }
}
