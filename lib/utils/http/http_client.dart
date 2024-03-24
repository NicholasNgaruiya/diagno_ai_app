import 'dart:convert';
import 'package:http/http.dart' as http;

class THttHelper {
  static const String _baseUrl = 'https://smart-restaurant-api.onrender.com/api/v1';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = '$_baseUrl/$endpoint';
    print('GET Request URL: $url'); // Print the URL
    final response = await http.get(Uri.parse(url));
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final url = '$_baseUrl/$endpoint';
    print('POST Request URL: $url'); // Print the URL
    final response = await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: json.encode(data));
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final url = '$_baseUrl/$endpoint';
    print('DELETE Request URL: $url'); // Print the URL
    final response = await http.delete(Uri.parse(url));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
