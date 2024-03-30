import 'package:restaurant_frontend/data/shop/services/admin_shop_service.dart';
import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';

class AdminRepository {
  final AdminShopService _adminShopService;
  AdminRepository(this._adminShopService);
  Future<Map<String, dynamic>> createProduct(ProductItem productItem) async {
    try {
      final response = await _adminShopService.createProduct(productItem);
      return response;
    } catch (e) {
      print('Error creating product: $e');
      rethrow;
    }
  }
}
