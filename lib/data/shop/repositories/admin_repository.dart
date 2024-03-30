import 'package:restaurant_frontend/data/shop/services/admin_shop_service.dart';
import 'package:restaurant_frontend/features/shop/admin/models/category_item.dart';
import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';

class AdminRepository {
  AdminRepository();
  Future<Map<String, dynamic>> createProduct(ProductItem productItem) async {
    try {
      final response = await AdminShopService().createProduct(productItem);
      return response;
    } catch (e) {
      print('Error creating product: $e');
      rethrow;
    }
  }

  Future<List<CategoryItem>> getCategories() async {
    try {
      final response = await AdminShopService().getCategoryList();
      return response;
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }
}
