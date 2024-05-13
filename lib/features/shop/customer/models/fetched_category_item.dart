// To parse this JSON data, do
//
//     final fetchedCategoryItem = fetchedCategoryItemFromJson(jsonString);

// FetchedCategoryItem fetchedCategoryItemFromJson(String str) => FetchedCategoryItem.fromJson(json.decode(str));

// String fetchedCategoryItemToJson(FetchedCategoryItem data) => json.encode(data.toJson());

import 'new_product_item.dart';

class FetchedCategoryItem {
  String id;
  String name;
  String description;
  List<Product> products;
  String image;

  FetchedCategoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.products,
    required this.image,
  });

  factory FetchedCategoryItem.fromJson(Map<String, dynamic> json) => FetchedCategoryItem(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        products: (json['products'] as List).map((productJson) => Product.fromJson(productJson)).toList(),
        image: json['image'],
      );

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'description': description,
  //       'products': List<dynamic>.from(products.map((x) => x.toJson())),
  //       'image': image,
  //     };
}
