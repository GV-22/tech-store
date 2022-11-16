import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/widgets/products/products_grid.dart';
import 'package:responsive_app/widgets/system/top_bar.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts =
        Provider.of<UserProvider>(context).favoriteProducts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBar(title: "Favorites"),
        ProductsGrid(products: favoriteProducts)
      ],
    );
  }
}
