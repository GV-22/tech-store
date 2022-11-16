import 'package:flutter/material.dart';
import 'package:responsive_app/widgets/cart/cart.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = "/cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: const Cart(),
    );
  }
}
