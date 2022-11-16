import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_app/models/order_entity.dart';
import 'package:responsive_app/screens/order_details_screen.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:sizer/sizer.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCard(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClickableColumn(
      onTap: () {
        if (isMobile) {
          Navigator.of(context).pushNamed(
            OrderDetailsScreen.routeName,
            arguments: order,
          );
        } else {
          EventBusController.fireEvent(
            EventData(cause: EventCause.viewOrder, data: order),
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
          "Ordered ${formatDate(order.orderedAt, "d MMMM yyyy")}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: isMobile ? 12 : 18),
        ),
        Text(
          "Delivery ${formatDate(order.deliveryDate, "d MMM yyyy")}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: isMobile ? 12 : 18),
        ),
        Text(
          "${to2Digits(order.items.length)} product(s)",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: grey400Color,
            fontSize: isMobile ? 12 : 18,
          ),
        ),
      ],
    );
  }
}
