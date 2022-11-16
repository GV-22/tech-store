import 'package:responsive_app/models/user_entity.dart';

class ReviewEntity {
  final int id;
  final String content;
  final UserEntity reviewBy;
  final double rating;

  ReviewEntity({
    required this.id,
    required this.content,
    required this.reviewBy,
    required this.rating,
  });
}