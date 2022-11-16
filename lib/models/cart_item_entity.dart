import 'package:responsive_app/models/product_entitty.dart';

class CartItemEntity {
  final ProductEntity product;
  int quantity;

  CartItemEntity({
    required this.product,
    this.quantity = 1,
  });

  double get amount => product.price * quantity;

  void updateQuantity(int value) {
    quantity = value;
  }

  @override
  String toString() {
    return 'CartItemEntity(product: $product quantity: $quantity)';
  }
}
