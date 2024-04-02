import 'package:restaurant_frontend/data/shop/services/admin_shop_service.dart';
import 'package:restaurant_frontend/features/shop/admin/models/category_item.dart';
import 'package:restaurant_frontend/features/shop/admin/models/create_category_item.dart';
import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';

import '../../../features/shop/admin/models/update_category_item.dart';

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

  Future<Map<String, dynamic>> updateCategory(UpdateCategoryItem updateCategoryItem) async {
    try {
      final response = await AdminShopService().updateCategory(updateCategoryItem);
      return response;
    } catch (e) {
      print('Error updating category: $e');
      rethrow;
    }
  }

  Future<void> deleteCategory() async {
    try {
      await AdminShopService().deleteCategory();
      print('Category deleted successfully');
    } catch (e) {
      print('Error deleting category: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createCategory(CreateCategoryItem createCategoryItem) async {
    try {
      final response = await AdminShopService().createCategory(createCategoryItem);
      return response;
    } catch (e) {
      print('Error creating category: $e');
      rethrow;
    }
  }
}
