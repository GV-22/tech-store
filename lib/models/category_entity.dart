import 'package:flutter/material.dart';

class CategoryEntity {
  final int id;
  final String label;
  final IconData icon;

  CategoryEntity({
    required this.id,
    required this.label,
    required this.icon,
  });

  @override
  String toString() => 'CategoryEntity(id: $id, label: $label, icon: $icon)';
}
