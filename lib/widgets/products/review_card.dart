import 'package:flutter/material.dart';
import 'package:responsive_app/models/review_entity.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/products/rating.dart';

class ReviewCard extends StatelessWidget {
  final ReviewEntity review;

  const ReviewCard(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: grey300Color),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          child: Text(review.reviewBy.fullName.characters.first),
        ),
        title: Text(review.reviewBy.fullName),
        subtitle: Text(review.content),
        // trailing: Text(review.rating.toString()),
        trailing: RatingValue(review.rating),
      ),
    );
  }
}
