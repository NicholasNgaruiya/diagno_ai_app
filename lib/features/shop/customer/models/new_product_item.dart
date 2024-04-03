class Product {
  String id;
  String name;
  String image;
  String category;
  String price;
  String description;
  bool isVegetarian;
  bool isVegan;
  bool isGlutenFree;
  bool isNutFree;
  bool isDairyFree;
  bool isOrganic;
  bool isLowSodium;
  bool isHighProtein;
  bool isWholeGrain;
  bool? isNonGmo;
  bool isLowCalorie;
  bool isHighFiber;
  bool isLowGlycemicIndex;
  bool isRichInAntioxidants;
  bool isAllergenFree;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.description,
    required this.isVegetarian,
    required this.isVegan,
    required this.isGlutenFree,
    required this.isNutFree,
    required this.isDairyFree,
    required this.isOrganic,
    required this.isLowSodium,
    required this.isHighProtein,
    required this.isWholeGrain,
    this.isNonGmo,
    required this.isLowCalorie,
    required this.isHighFiber,
    required this.isLowGlycemicIndex,
    required this.isRichInAntioxidants,
    required this.isAllergenFree,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        category: json['category'],
        price: json['price'],
        description: json['description'],
        isVegetarian: json['is_vegetarian'],
        isVegan: json['is_vegan'],
        isGlutenFree: json['is_gluten_free'],
        isNutFree: json['is_nut_free'],
        isDairyFree: json['is_dairy_free'],
        isOrganic: json['is_organic'],
        isLowSodium: json['is_low_sodium'],
        isHighProtein: json['is_high_protein'],
        isWholeGrain: json['is_whole_grain'],
        isNonGmo: json['is_non_gmo'],
        isLowCalorie: json['is_low_calorie'],
        isHighFiber: json['is_high_fiber'],
        isLowGlycemicIndex: json['is_low_glycemic_index'],
        isRichInAntioxidants: json['is_rich_in_antioxidants'],
        isAllergenFree: json['is_allergen_free'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'category': category,
        'price': price,
        'description': description,
        'is_vegetarian': isVegetarian,
        'is_vegan': isVegan,
        'is_gluten_free': isGlutenFree,
        'is_nut_free': isNutFree,
        'is_dairy_free': isDairyFree,
        'is_organic': isOrganic,
        'is_low_sodium': isLowSodium,
        'is_high_protein': isHighProtein,
        'is_whole_grain': isWholeGrain,
        'is_non_gmo': isNonGmo,
        'is_low_calorie': isLowCalorie,
        'is_high_fiber': isHighFiber,
        'is_low_glycemic_index': isLowGlycemicIndex,
        'is_rich_in_antioxidants': isRichInAntioxidants,
        'is_allergen_free': isAllergenFree,
      };
}
