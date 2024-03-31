import 'dart:convert';

import 'package:restaurant_frontend/features/shop/admin/models/category_item.dart';
import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

class AdminShopService {
  final String baseUrl = 'https://smart-restaurant-api.onrender.com/api/v1';

  // AdminShopService(this.baseUrl);

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
      request.fields['name'] = productItem.productName;
      request.fields['category'] = productItem.category;
      request.fields['price'] = productItem.price.toString();
      // request.fields['image'] = productItem.imageBase64;
      request.fields['description'] = productItem.description;

      //Add image file
      // request.files.add(http.MultipartFile.fromBytes('image', await File(productItem.image.path).readAsBytes(), filename: productItem.image.path.split('/').last));
      request.files.add(await http.MultipartFile.fromPath('image', productItem.image.path));

      var response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        return json.decode(responseData);
      } else {
        throw Exception('Failed to create product ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  Future<List<CategoryItem>> getCategoryList() async {
    try {
      //Retrieve the access token from the local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      print(accessToken);
      if (accessToken != null) {
        print('$baseUrl/inventory/categories/');
        final response = await http.get(
          Uri.parse('$baseUrl/inventory/categories/'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          },
        );
        print('request sent');
        if (response.statusCode == 200) {
          // final List<dynamic> responseData = json.decode(response.body);
          // return responseData.map((e) => CategoryItem.fromJson(e)).toList();
          print('request successful');
          final List<dynamic> categoryList = json.decode(response.body);
          print(categoryList);
          return categoryList.map((categoryJson) => CategoryItem.fromJson(categoryJson)).toList();
        } else if (response.statusCode == 400) {
          throw Exception('Invalid request');
        } else if (response.statusCode == 401) {
          throw Exception('Unauthorized');
        } else if (response.statusCode == 500) {
          throw Exception('Server error');
        } else {
          print('Failed to get categories ${response.statusCode}');
          throw Exception('Failed to get categories ${response.statusCode}');
        }
      } else {
        throw Exception('Access token not found');
      }
    } catch (e) {
      // throw Exception('Error getting categories: $e');
      throw Exception('Error getting categories: $e');
    }
  }
}
