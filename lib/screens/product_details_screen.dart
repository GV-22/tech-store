import 'package:flutter/material.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/widgets/products/product_viewer.dart';


class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = "/product-details-screen";
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments;

    if (product is! ProductEntity) {
      throw "Missing product";
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: ProductViewer(product),
    );
  }
}
