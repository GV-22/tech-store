import 'package:flutter/material.dart';
import 'package:responsive_app/widgets/order/payment_completed.dart';

class PaymentCompletedScreen extends StatelessWidget {
  static const String routeName = "/payment-completed";

  const PaymentCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: const PaymentCompleted(),
    );
  }
}
