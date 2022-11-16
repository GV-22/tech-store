import 'package:flutter/material.dart';
import 'package:responsive_app/dummy.dart';
import 'package:responsive_app/models/category_entity.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/models/review_entity.dart';

class StoreProvider with ChangeNotifier {
  final List<ProductEntity> _products = [];
  final List<CategoryEntity> _categories = [];

  List<ProductEntity> get products => [..._products];
  List<CategoryEntity> get categories => [..._categories];

  CategoryEntity getCategoryById(int categoryId) {
    try {
      return categories.singleWhere((element) => element.id == categoryId);
    } catch (e) {
      throw "Unknown category with id $categoryId";
    }
  }

  void _setCategories(List<CategoryEntity> data) {
    _categories.clear();
    _categories.addAll(data);

    notifyListeners();
  }

  void _setProducts(List<ProductEntity> data) {
    _products.clear();
    _products.addAll(data);

    notifyListeners();
  }

  void updateProductStock(ProductEntity product, int value) {
    product.updateStock(value);

    notifyListeners();
  }

  void addReviewToProuct(ProductEntity product, ReviewEntity reviewEntity) {
    product.addReview(reviewEntity);

    notifyListeners();
  }

  void fetchCategories() {
    _setCategories(dummyCategories);
  }
 
  void fetchProducts() {
    _setProducts(dummyProducts);
  }

  void loadData() {
    fetchCategories();
    fetchProducts();
  }
  
}
