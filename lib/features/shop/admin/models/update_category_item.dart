import 'dart:io';

class UpdateCategoryItem {
  final String name;
  final String? description;
  final File? image;

  UpdateCategoryItem({
    required this.name,
    required this.description,
    required this.image,
  });

  factory UpdateCategoryItem.fromJson(Map<String, dynamic> json) {
    return UpdateCategoryItem(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
