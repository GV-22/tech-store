import 'package:flutter/material.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/products/product_card.dart';
import 'package:sizer/sizer.dart';

class ProductsHorizontalList extends StatelessWidget {
  final List<ProductEntity> products;
  const ProductsHorizontalList(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = isMobile ? 120.sp : 80.sp;
    return Container(
      height: size,
      margin: EdgeInsets.symmetric(vertical: isMobile ? 10.sp : 6.sp),
      child: products.isEmpty
          ? const Center(
              child: Text("Pas de produit dans cette catégorie"),
            )
          : GridView.builder(
              itemCount: products.length,
              shrinkWrap: false,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: isMobile ? 120.sp : 80.sp, // width
                maxCrossAxisExtent: size, // height
                mainAxisSpacing: 8.sp,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext bCtx, i) => ProductCard(products[i]),
            ),
    );
  }
}
