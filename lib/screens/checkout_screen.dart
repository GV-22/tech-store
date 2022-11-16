import 'package:flutter/material.dart';
import 'package:responsive_app/widgets/order/checkout.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = "/checkout";

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: const Checkout(),
    );
  }
}
