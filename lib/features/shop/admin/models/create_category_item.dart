import 'dart:io';

class CreateCategoryItem {
  final String name;
  final String? description;
  final File? image;

  CreateCategoryItem({
    required this.name,
    required this.description,
    required this.image,
  });

  factory CreateCategoryItem.fromJson(Map<String, dynamic> json) {
    return CreateCategoryItem(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
