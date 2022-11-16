import 'package:responsive_app/models/category_entity.dart';
import 'package:responsive_app/models/review_entity.dart';

class ProductEntity {
  final int id;
  final String label;
  final String description;
  final String mainImageUrl;
  final List<String> gallery;
  final List<ReviewEntity> reviews;
  final double price;
  final CategoryEntity category;
  int stock;

  ProductEntity({
    required this.id,
    required this.label,
    required this.description,
    required this.mainImageUrl,
    required this.category,
    this.gallery = const [],
    this.reviews = const [],
    required this.price,
    required this.stock,
  });


  void updateStock(int value) {
    stock -= value;
  }

  void addReview(ReviewEntity reviewEntity) {
    reviews.insert(0, reviewEntity);
  }

  double get rating {
    double rating = 0;
    for (var element in reviews) {
      rating += element.rating;
    }
    
    return (rating / reviews.length).ceilToDouble();
  }

  @override
  String toString() {
    return 'ProductEntity(id: $id, label: $label, description: $description, price: $price'
        ' mainImageUrl: $mainImageUrl, gallery: $gallery, reviews: $reviews, stock: $stock, category: $category)';
  }
}
