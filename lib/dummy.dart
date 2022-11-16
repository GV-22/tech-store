import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_app/models/category_entity.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/models/review_entity.dart';
import 'package:responsive_app/models/user_entity.dart';

final List<CategoryEntity> dummyCategories = [
  CategoryEntity(id: 1, label: "Phone", icon: Icons.phone_iphone),
  // CategoryEntity(id: 2, label: "Case", icon: Icons.cases),
  CategoryEntity(id: 2, label: "Tablet", icon: Icons.tablet_mac),
  CategoryEntity(id: 3, label: "Computer", icon: Icons.computer_rounded),
  CategoryEntity(id: 4, label: "Monitor", icon: Icons.monitor_rounded),
  CategoryEntity(id: 5, label: "Keyboard", icon: Icons.keyboard_alt_rounded),
  CategoryEntity(id: 6, label: "Headphone", icon: Icons.headphones_rounded),
  CategoryEntity(id: 7, label: "Mouse", icon: Icons.mouse_rounded),
];

final List<ProductEntity> dummyProducts = List.generate(70, (int index) {
  return ProductEntity(
    id: index + 1,
    label: "Product ${index + 1}",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget massa"
        "interdum, fringilla arcu sed, convallis lorem. Curabitur mollis"
        "convallis neque quis auctor. Integer ligula elit, ullamcorper vitae"
        "euismod et, fermentum non quam.",
    mainImageUrl: "-",
    category: dummyCategories[Random().nextInt(dummyCategories.length)],
    price: (Random().nextDouble() * 3000000).ceilToDouble(),
    stock: Random().nextInt(200) + 50,
    reviews: List.generate(10, (int index) {
      return ReviewEntity(
        id: 1,
        content: "I like it",
        reviewBy: dummyUsers[Random().nextInt(dummyUsers.length)],
        rating: (Random().nextDouble() * 5.1).ceilToDouble(),
      );
    }),
  );
});

List<UserEntity> dummyUsers = List.generate(
  15,
  (int index) => UserEntity(
    id: index + 1,
    fullName: "User ${index + 1}",
    email: "user${index+1}@mail.com"
  ),
);

// final dummyProducts