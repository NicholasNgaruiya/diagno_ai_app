import 'dart:convert';

import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

class AdminShopService {
  final String baseUrl;

  AdminShopService(this.baseUrl);

  Future<Map<String, dynamic>> createProduct(ProductItem productItem) async {
    try {
      //Retrieve the access token from the local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/inventory/products/create/'));

      //Set authorization header with the access token
      request.headers['Authorization'] = 'Bearer $accessToken';

      //Add text fields
      request.fields['product_name'] = productItem.productName;
      request.fields['category'] = productItem.category;
      request.fields['price'] = productItem.price.toString();
      request.fields['description'] = productItem.description;

      //Add image file
      // request.files.add(http.MultipartFile.fromBytes('image', await File(productItem.image.path).readAsBytes(), filename: productItem.image.path.split('/').last));
      request.files.add(await http.MultipartFile.fromPath('image', productItem.image.path));

      var response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        return json.decode(responseData);
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }
}
