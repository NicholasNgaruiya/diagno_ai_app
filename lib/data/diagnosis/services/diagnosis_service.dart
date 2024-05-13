import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/device/device_utility.dart';
import '../../../utils/local_storage/storage_utility.dart';

class DiagnosisService {
  final String baseUrl = 'https://smart-doctor.onrender.com/api/v1';

  Future<Map<String, dynamic>> predictDisease(String symptoms) async {
    print('Type of symptoms: ${symptoms.runtimeType}'); // Print type of symptomsss
    print('The received symptoms look like this: $symptoms');
    try {
      //Retrieve the access token from local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      bool hasInternet = await TDeviceUtils.hasInternetConnection();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      if (!hasInternet) {
        throw Exception('No internet connection');
      }
      //Make a post request to the server
      String url = '$baseUrl/model/predict/';
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken', // Include access token in the Authorization header
      };

      final Map<String, dynamic> requestBody = {'symptoms': symptoms};

      print('Request URL: $url');
      print('Request Headers: $headers');
      print(
        'Request Body: ${jsonEncode(requestBody)}',
      );
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'symptoms': symptoms}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
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
      } else if (response.statusCode == 500) {
        //Handle 500 Server Error
        // return json.decode(response.body);
        throw Exception('${response.statusCode} Server Error');
      } else {
        throw Exception('Failed to predict disease');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to predict disease2');
    }
  }
}
