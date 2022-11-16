import 'package:flutter/material.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/widgets/order/orders_grid.dart';
import 'package:responsive_app/widgets/system/top_bar.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin {
  late TabController _tabController;

  final int tabCount = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabCount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(title: "Orders"),
        Expanded(
          child: DefaultTabController(
            length: tabCount,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 2),
                    ),
                  ),
                  isScrollable: true,
                  tabs: const [
                    Tab(text: "In progress"),
                    Tab(text: "Completed"),
                    Tab(text: "Cancelled"),
                  ],
                ),
                const SizedBox(height: 24,),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      OrdersGrid(OrderStatus.inProgress),
                      OrdersGrid(OrderStatus.completed),
                      OrdersGrid(OrderStatus.cancelled),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
