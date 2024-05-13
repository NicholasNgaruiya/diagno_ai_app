import 'dart:convert';
import 'package:http/http.dart' as http;

import '../device/device_utility.dart';

class THttHelper {
  static const String _baseUrl = 'https://smart-doctor.onrender.com/api/v1';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(
    String endpoint,
  ) async {
    if (await TDeviceUtils.hasInternetConnection()) {
      final url = '$_baseUrl/$endpoint';
      print('GET Request URL: $url'); // Print the URL
      final response = await http.get(
        Uri.parse(url),
      );
      return _handleResponse(response);
    } else {
      throw Exception('No Internet Connection');
    }
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    if (await TDeviceUtils.hasInternetConnection()) {
      final url = '$_baseUrl/$endpoint';
      print('POST Request URL: $url'); // Print the URL
      final response = await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: json.encode(data));
      return _handleResponse(response);
    } else {
      throw Exception('No Internet Connection');
    }
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    if (await TDeviceUtils.hasInternetConnection()) {
      final url = '$_baseUrl/$endpoint';
      print('DELETE Request URL: $url'); // Print the URL
      final response = await http.delete(Uri.parse(url));
      return _handleResponse(response);
    } else {
      throw Exception('No Internet Connection');
    }
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 201) {
      return json.decode(response.body);
    } else if (response.statusCode == 204) {
      //Handle 204 No Content
      return json.decode(response.body);
    } else if (response.statusCode == 400) {
      //Handle 400 Bad Request Error
      // return json.decode(response.body);
      throw Exception('${response.statusCode} Bad Request Error');
    } else if (response.statusCode == 401) {
      //Handle 401 Unauthorized Error
      // return json.decode(response.body);
      throw Exception('${response.statusCode} Unauthorized Error');
    } else if (response.statusCode == 403) {
      //Handle 403 Forbidden Error
      // return json.decode(response.body);
      throw Exception('${response.statusCode} Forbidden Error');
    } else if (response.statusCode == 404) {
      //Handle 404 Not found Error
      // return json.decode(response.body);
      throw Exception('${response.statusCode} Not found Error');
    } else if (response.statusCode >= 500) {
      //Handle 500 Server Error
      // return json.decode(response.body);
      throw Exception('${response.statusCode} Server Error');
    } else {
      // throw Exception('Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
