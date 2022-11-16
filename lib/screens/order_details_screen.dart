import 'package:flutter/material.dart';
import 'package:responsive_app/models/order_entity.dart';
import 'package:responsive_app/widgets/order/order_viewer.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const String routeName = "/order-details-screen";

  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments;

    if (order is! OrderEntity) {
      throw "Missing order";
    }
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: OrderViewer(order),
    );
  }
}
