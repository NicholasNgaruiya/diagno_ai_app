import 'dart:convert';

import 'package:restaurant_frontend/features/shop/admin/models/category_item.dart';
import 'package:restaurant_frontend/features/shop/admin/models/create_category_item.dart';
import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_frontend/features/shop/admin/models/update_category_item.dart';
import 'dart:io';

import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

import '../../../utils/device/device_utility.dart';

class AdminShopService {
  final String baseUrl = 'https://smart-restaurant-api.onrender.com/api/v1';

  // AdminShopService(this.baseUrl);

  Future<Map<String, dynamic>> createProduct(ProductItem productItem) async {
    try {
      //Retrieve the access token from the local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      bool hasInternet = await TDeviceUtils.hasInternetConnection();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      //check if has internet connection
      if (!hasInternet) {
        throw Exception('No Internet Connection');
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

  Future<Map<String, dynamic>> createCategory(CreateCategoryItem createCategoryItem) async {
    try {
      //Retrieve the access token from the local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      bool hasInternet = await TDeviceUtils.hasInternetConnection();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      //check if has internet connection
      if (!hasInternet) {
        throw Exception('No Internet Connection');
      }
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/inventory/categories/create/'));

      //Set authorization header with the access token
      request.headers['Authorization'] = 'Bearer $accessToken';

      //Add text fields
      request.fields['name'] = createCategoryItem.name;
      request.fields['description'] = createCategoryItem.description ?? '';

      //Add image file
      if (createCategoryItem.image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', createCategoryItem.image!.path));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        return json.decode(responseData);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else if (response.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Failed to create category ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating category: $e');
    }
  }

  Future<Map<String, dynamic>> updateCategory(UpdateCategoryItem updateCategoryItem) async {
    try {
      // Retrieve the access token and category ID from local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      String? categoryId = await TLocalStorage.getString('selectedCategoryId');

      bool hasInternet = await TDeviceUtils.hasInternetConnection();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      if (categoryId == null) {
        throw Exception('Category ID not found');
      }
      // Check for internet connection
      if (!hasInternet) {
        throw Exception('No Internet Connection');
      }

      //construct the request url with the category ID
      String url = '$baseUrl/inventory/categories/$categoryId/update/';
      print('URL: $url');

      var request = http.MultipartRequest('PUT', Uri.parse(url));

      //Set authorization header with the access token
      request.headers['Authorization'] = 'Bearer $accessToken';

      //Add textFields
      request.fields['name'] = updateCategoryItem.name;
      request.fields['description'] = updateCategoryItem.description ?? '';

      // Add image file if available
      if (updateCategoryItem.image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', updateCategoryItem.image!.path));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return json.decode(responseData);
      } else {
        throw Exception('Failed to update category ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  // Future<Map<String,dynamic>> deleteCategory()
  Future<List<CategoryItem>> getCategoryList() async {
    try {
      //Retrieve the access token from the local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      bool hasInternet = await TDeviceUtils.hasInternetConnection();
      print(accessToken);
      if (accessToken != null) {
        if (!hasInternet) {
          throw Exception('No Internet Connection');
        }
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
