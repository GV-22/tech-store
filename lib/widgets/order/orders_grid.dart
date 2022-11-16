import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/ui_provider.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/order/order_card.dart';
import 'package:sizer/sizer.dart';

class OrdersGrid extends StatelessWidget {
  final OrderStatus orderStatus;
  const OrdersGrid(this.orderStatus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final orders = userProvider.orders
        .where((item) => item.status == orderStatus)
        .toList();

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.shopping_bag_outlined, size: 50),
            SizedBox(height: 24),
            Text("No order here!")
          ],
        ),
      );
    }

    final uiPorivider = Provider.of<UiProvider>(context);

    int axisCount = 4;
    if (isMobile) {
      axisCount = isLandscape ? 4 : 2;
    } else {
      if (isLandscape) {
        axisCount = uiPorivider.isSideBarOpened ? 3 : 4;
      } else {
        axisCount = uiPorivider.isSideBarOpened ? 2 : 4;
      }
    }

    return GridView.builder(
      itemCount: orders.length,
      shrinkWrap: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: axisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 18,
        mainAxisExtent: isMobile ? null : 250,
      ),
      padding: EdgeInsets.only(top: 2.sp, right: 12.sp),
      itemBuilder: (BuildContext bCtx, i) => OrderCard(orders[i]),
    );
  }
}
