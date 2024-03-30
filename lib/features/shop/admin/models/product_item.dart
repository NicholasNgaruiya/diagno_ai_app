import 'dart:io';

class ProductItem {
  final String productName;
  final String category;
  final double price;
  final String description;
  final File image;

  ProductItem({
    required this.productName,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
  });
}
