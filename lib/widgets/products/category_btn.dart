import 'package:flutter/material.dart';
import 'package:responsive_app/models/category_entity.dart';
import 'package:sizer/sizer.dart';

class CategoryBtn extends StatelessWidget {
  final CategoryEntity category;
  final bool selected;

  const CategoryBtn({
    required this.category,
    this.selected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.secondary),
        color: selected ? colorScheme.primary : Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            category.icon,
            color: selected ? Colors.white : colorScheme.primary,
          ),
          SizedBox(width: 3.sp),
          Text(
            category.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
