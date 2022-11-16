import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/dummy.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/products/category_btn.dart';
import 'package:responsive_app/widgets/products/products_horizontal_list.dart';
import 'package:responsive_app/widgets/products/rating.dart';
import 'package:responsive_app/widgets/products/review_card.dart';
import 'package:responsive_app/widgets/system/fill_btn.dart';
import 'package:sizer/sizer.dart';

class ProductViewer extends StatelessWidget {
  final ProductEntity product;

  const ProductViewer(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final contentPadding = isMobile ? 12.sp : 8.sp;
    final contentSpacing = isMobile ? 8.sp : 8.sp;

    final userProvider = Provider.of<UserProvider>(context);
    final cartItem = userProvider.getCartItem(product);
    final isFavorite = userProvider.isFavoriteProduct(product.id);
    // print("....cartItem...$cartItem");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: isMobile ? 200 : 200,
          decoration: const BoxDecoration(
            color: grey100Color,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () => updateFavorite(context),
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: isFavorite ? Colors.blue : grey400Color,
                  ),
                ),
              )
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: contentPadding, top: contentPadding),
        //   child: CategoryBtn(category: product.category, selected: true),
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: contentPadding,
            top: contentPadding,
            right: contentPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryBtn(category: product.category, selected: true),
              Text("XOF ${formatNumber(product.price)}"),
            ],
          ),
        ),
        SizedBox(height: contentSpacing),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
              // top: contentPadding,
              left: contentPadding,
              right: contentPadding,
              bottom: 0,
            ),
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                product.label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: contentSpacing),
              Text(
                product.description,
                style: TextStyle(
                  color: grey400Color,
                  fontSize: isMobile ? 10 : 14,
                ),
              ),
              // SizedBox(height: contentSpacing),
              // Text("XOF ${formatNumber(product.price)}"),
              SizedBox(height: contentSpacing),
              Text("Stock ${formatNumber(product.stock)}"),
              SizedBox(height: contentSpacing),
              SizedBox(height: contentSpacing),
              if (isMobile) ...[
                const Text("Related products"),
                ProductsHorizontalList(dummyProducts.getRange(10, 26).toList()),
                SizedBox(height: contentSpacing * 3),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Reviews (${formatNumber(product.reviews.length)})"),
                  RatingValue(product.rating)
                ],
              ),
              ...product.reviews.map((e) => ReviewCard(e)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          // height: 50,
          child: FillBtn(
            label: cartItem == null ? "Add to cart" : "Remove from the cart",
            onPressed: () => _addToCart(context, cartItem == null ? 1 : 0),
          ),
        ),
        // Container(
        //   height: isMobile ? 8.h : 5.h,
        //   child: AddToCartBtns(cartItem: cartItem),
        // )
      ],
    );
  }

  void _addToCart(BuildContext context, int quantity) {
    final result = Provider.of<UserProvider>(context, listen: false)
        .updateCart(product, quantity);

    if (result == 0) {
      appSnackbar(
        context: context,
        text: "${product.label} added to cart",
      );
    } else if (result == -1) {
      appSnackbar(
        context: context,
        text: "${product.label} remove from the to cart",
      );
    }
  }

  void updateFavorite(BuildContext context) {
    // appSnackbar
    final favorite = Provider.of<UserProvider>(context, listen: false)
        .updateFavoriteProducts(product);
    appSnackbar(
      context: context,
      text: favorite
          ? "${product.label} added to favorites"
          : "${product.label} removed from favorites",
    );
  }
}
