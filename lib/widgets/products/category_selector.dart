import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_app/models/category_entity.dart';

import 'category_btn.dart';

class CategorySelector extends StatefulWidget {
  final List<CategoryEntity> categories;
  final Function(CategoryEntity?) onFilterChange;

  const CategorySelector({
    required this.onFilterChange,
    required this.categories,
    Key? key,
  }) : super(key: key);

  @override
  State<CategorySelector> createState() =>
      _CategorySelectorState();
}

class _CategorySelectorState
    extends State<CategorySelector> {
  CategoryEntity? _currentCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) return const SizedBox();

    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: widget.categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ClickableContainer(
            onTap: () => _setSelectedCategory(null, index),
              margin: const EdgeInsets.only(right: 10),
              child: CategoryBtn(
                category: CategoryEntity(
                  id: 0,
                  label: "All",
                  icon: Icons.category,
                ),
                selected: _currentCategory == null,
              ),
            );
          }

          final category = widget.categories[index - 1];
          bool isSelected = _currentCategory == null
              ? false
              : _currentCategory!.id == category.id;

          return ClickableContainer(
          onTap: () => _setSelectedCategory(category, index - 1),
            margin: const EdgeInsets.only(right: 10),
            child: CategoryBtn(
              category: category,
              selected: isSelected,
            ),
          );
        },
      ),
    );
  }

  void _setSelectedCategory(CategoryEntity? categoryEntity, int index) {
    setState(() {
      _currentCategory = categoryEntity;
      widget.onFilterChange(categoryEntity);
    });
  }
}
