class CategoryItem {
  final String id;
  final String name;
  final String description;
  final String image;

  CategoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
