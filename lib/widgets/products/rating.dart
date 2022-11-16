import 'package:flutter/material.dart';
import 'package:responsive_app/utils/ui.dart';

class RatingValue extends StatelessWidget {
  final double rating;
  const RatingValue(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$rating",
          style: TextStyle(
            fontSize: isMobile ? 10 : null,
            color: grey400Color
          ),
        ),
        // SizedBox(width: 4.sp),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: isMobile ? 16 : null,
        )
      ],
    );
  }
}
