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
      try {
        final url = '$_baseUrl/$endpoint';
        print('GET Request URL: $url'); // Print the URL
        final response = await http.get(
          Uri.parse(url),
        );
        return _handleGetResponse(response);
      } on http.ClientException catch (e) {
        print('Error occurred: $e');
        throw Exception('Connection timeout.Please check your connection and try again.');
        // throw {'error': e.message};
      }
    } else {
      throw Exception('No Internet Connection');
      // return {'error': 'No Internet Connection'};
    }
  }

  //Helper method to handle GET request response
  static Map<String, dynamic> _handleGetResponse(http.Response response) {
    //?remember to use try catch block
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 204) {
      // return jsonDecode(response.body); //? use this if the code below don't work
      return {};
      // return {'message': 'OTP verification successful'};
    } else {
      throw _extractErrorMessage(response);
    }
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    if (await TDeviceUtils.hasInternetConnection()) {
      try {
        final url = '$_baseUrl/$endpoint';
        print('POST Request URL: $url'); // Print the URL
        final response = await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: json.encode(data));
        return _handlePostResponse(response);
      } on http.ClientException catch (e) {
        print('Error occurred: $e');
        throw Exception('Connection timeout.Please check your connection and try again.');
        // throw {'error': e.message};
      }
    } else {
      throw Exception('No Internet Connection');
      // return {'error': 'No Internet Connection'};
    }
  }

  //Helper method to handle GET request response
  static Map<String, dynamic> _handlePostResponse(http.Response response) {
    //?remember to use try catch block

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else if (response.statusCode == 204) {
      // return jsonDecode(response.body);
      return {};
    } else {
      throw _extractErrorMessage(response);
    }
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    if (await TDeviceUtils.hasInternetConnection()) {
      final url = '$_baseUrl/$endpoint';
      print('DELETE Request URL: $url'); // Print the URL
      final response = await http.delete(Uri.parse(url));
      return _handleDeleteResponse(response);
    } else {
      throw Exception('No Internet Connection');
      // return {'error': 'No Internet Connection'};
    }
  }

  // Helper method to handle DELETE request response
  static Map<String, dynamic> _handleDeleteResponse(http.Response response) {
    if (response.statusCode == 204) {
      return {'message': 'Deleted successfully'};
    } else {
      throw _extractErrorMessage(response);
    }
  }

  // Handle the HTTP response
  // static Map<String, dynamic> _handleResponse(http.Response response) {
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else if (response.statusCode == 201) {
  //     return json.decode(response.body);
  //   } else if (response.statusCode == 204) {
  //     //Handle 204 No Content
  //     return json.decode(response.body);
  //   } else if (response.statusCode == 400) {
  //     //Handle 400 Bad Request Error
  //     return json.decode(response.body);
  //     // throw Exception('${response.statusCode} Bad Request Error');
  //   } else if (response.statusCode == 401) {
  //     //Handle 401 Unauthorized Error
  //     // return json.decode(response.body);
  //     // throw Exception('${response.statusCode} Unauthorized Error');
  //     // throw Exception('Invalid email or password');
  //   } else if (response.statusCode == 403) {
  //     //Handle 403 Forbidden Error
  //     // return json.decode(response.body);
  //     throw Exception('${response.statusCode} Forbidden Error');
  //   } else if (response.statusCode == 404) {
  //     //Handle 404 Not found Error
  //     // return json.decode(response.body);
  //     throw Exception('${response.statusCode} Not found Error');
  //   } else if (response.statusCode >= 500) {
  //     //Handle 500 Server Error
  //     // return json.decode(response.body);
  //     throw Exception('${response.statusCode} Server Error');
  //   } else {
  //     // throw Exception('Failed to load data: ${response.statusCode}');
  //     throw Exception('Failed to load data: ${response.statusCode}');
  //   }
  // }

  static String _extractErrorMessage(http.Response response) {
    try {
      // if(response.statusCode == 204) {}
      Map<String, dynamic> errorBody = json.decode(response.body);
      if (errorBody.isNotEmpty) {
        String firstKey = errorBody.keys.first;
        dynamic errorMessage = errorBody[firstKey];
        // return Exception(errorMessage); //?the right way
        // return Exception('$errorMessage (${response.statusCode})');
        if (errorMessage is List) {
          //Concatenate the elements of the list into a single String
          return errorMessage.join(' ');
        } else {
          return errorMessage.toString();
        }
      }
    } catch (e) {
      //If unable to parse error body or extract error message,return generic error
      return 'Failed to handle error response : ${response.statusCode}';
    }
    return 'Failed to handle error response : ${response.statusCode}';
  }
}
