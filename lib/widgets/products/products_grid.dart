import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/provider/ui_provider.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/products/product_card.dart';
import 'package:sizer/sizer.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGrid({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("No product."),
        ),
      );
    }

    final uiPorivider = Provider.of<UiProvider>(context);
    // print("....uiPorivider.isSideBarOpened...${uiPorivider.isSideBarOpened}");

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

    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: axisCount,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          mainAxisExtent: isMobile ? null : 250,
        ),
        padding: EdgeInsets.only(top: 2.sp, right: 12.sp),
        itemBuilder: (BuildContext bCtx, i) => ProductCard(products[i]),
      ),
    );
  }
}
