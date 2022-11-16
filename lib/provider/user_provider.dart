import 'package:flutter/material.dart';
import 'package:responsive_app/dummy.dart';
import 'package:responsive_app/models/cart_item_entity.dart';
import 'package:responsive_app/models/order_entity.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/models/user_entity.dart';
import 'package:responsive_app/utils/types.dart';

class UserProvider with ChangeNotifier {
  final List<CartItemEntity> _cart = [];
  final List<ProductEntity> _favoriteProducts = [];
  final List<OrderEntity> _orders = [];

  UserEntity? _user;

  List<CartItemEntity> get cart => [..._cart];
  List<ProductEntity> get favoriteProducts => [..._favoriteProducts];
  List<OrderEntity> get orders => [..._orders];
  UserEntity? get user => _user;

  double cartAmount() {
    double amount = 0;
    for (var item in _cart) {
      amount += item.amount;
    }

    return amount;
  }

  void login(String email) {
    _user = UserEntity(
      id: 1,
      fullName: email.split("@").first,
      email: email
    );
    notifyListeners();
  }

  CartItemEntity? getCartItem(ProductEntity product) {
    try {
      return cart.singleWhere((item) => item.product.id == product.id);
    } catch (_) {
      return null;
    }
  }

  bool isFavoriteProduct(int productId) {
    try {
      _favoriteProducts.singleWhere((element) => element.id == productId);
      return true;
    } catch (e) {
      return false;
    }
  }

  int updateCart(ProductEntity product, int quantity) {
    final CartItemEntity? cartItem = getCartItem(product);
    int result = 0; // 0 added, -1 removed, 1 updated

    if (cartItem == null) {
      _cart.add(CartItemEntity(product: product));
      result = 0;
    } else {
      cartItem.updateQuantity(quantity);
      result = 1;
      // add the product to the cart
      if (cartItem.quantity == 0) {
        // remove
        _cart.remove(cartItem);
        result = -1;
      }
    }
    // print("cartItem cart state => $_cart");

    notifyListeners();

    return result;
  }

  bool updateFavoriteProducts(ProductEntity product) {
    bool result = false;
    if (isFavoriteProduct(product.id)) {
      _favoriteProducts.remove(product);
    } else {
      _favoriteProducts.add(product);
      result = true;
    }

    notifyListeners();
    return result;
  }

  void addNewOrder() {
    // add new order
    final OrderEntity order = OrderEntity(
      id: _orders.length + 1,
      items: [..._cart],
      orderedAt: DateTime.now(),
      orderedBy: dummyUsers.first,
    );
    _orders.insert(0, order);
    // clear cart
    _cart.clear();

    notifyListeners();
  }

  void updateOrderStatus(OrderEntity order, OrderStatus status) {
    order.updateStatus(status);

    notifyListeners();
  }
}
