import 'dart:io';

class ProductItem {
  final String productName;
  final String category;
  final double price;
  final String description;
  final File image;
  // final String imageBase64;

  ProductItem({
    required this.image,
    // required this.imageBase64,
    required this.productName,
    required this.category,
    required this.price,
    required this.description,
  });
}
