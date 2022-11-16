import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/models/category_entity.dart';
import 'package:responsive_app/provider/store_provider.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/products/category_selector.dart';
import 'package:responsive_app/widgets/products/products_grid.dart';
import 'package:responsive_app/widgets/system/top_bar.dart';

class HomeBoard extends StatefulWidget {
  const HomeBoard({Key? key}) : super(key: key);

  @override
  State<HomeBoard> createState() => _HomeBoardState();
}

class _HomeBoardState extends State<HomeBoard> {
  CategoryEntity? _currentCategory;

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);

    final products = _currentCategory == null
        ? storeProvider.products
        : storeProvider.products
            .where((e) => e.category.id == _currentCategory?.id)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBar(title: "Store"),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CategorySelector(
                categories: storeProvider.categories,
                onFilterChange: (category) {
                  setState(() => _currentCategory = category);
                },
              ),
              SizedBox(height: isMobile ? 14 : 24),
              ProductsGrid(products: products)
            ],
          ),
        )
      ],
    );
  }
}
