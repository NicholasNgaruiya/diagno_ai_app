import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../features/authentication/models/user_model.dart';
import '../../../features/profile/models/update_profile_model.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/local_storage/storage_utility.dart';

class AuthService {
  //register user using http_client
  static const String _baseUrl = 'auth';
  static const String _profileUrl = 'https://smart-doctor.onrender.com/api/v1/auth/profile';

  //Method to signup
  static Future<Map<String, dynamic>> signUp(UserModel user) async {
    final data = user.toJson();

    return await THttHelper.post('$_baseUrl/register/', data);
  }

  //Method to send resetPassword
  static Future<Map<String, dynamic>> resetPassword(String email) async {
    final data = {'email': email};
    return await THttHelper.post('$_baseUrl/password-reset/', data);
  }

  //Method to signin
  static Future<Map<String, dynamic>> signIn(String email, String password) async {
    final data = {'email': email, 'password': password};
    return await THttHelper.post('$_baseUrl/login/', data);
  }

  //Method to verify OTP
  static Future<Map<String, dynamic>> verifyOTP(String otp) async {
    final data = {'otp': otp};
    return await THttHelper.post('$_baseUrl/verify-email/', data);
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      //Retrieve the access token and category ID from local storage
      String? accessToken = await TLocalStorage.getString('access_token');
      String? userId = await TLocalStorage.getString('id');

      bool hasInternet = await TDeviceUtils.hasInternetConnection();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      if (userId == null) {
        throw Exception('User ID not found');
      }
      if (!hasInternet) {
        throw Exception('No internet connection');
      }
      final response = await http.get(
        Uri.parse('$_profileUrl/$userId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      //print url sent and the url
      print('url sent: ${'$_profileUrl/$userId'}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        throw Exception('Bad Request Error');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized Error');
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error');
      } else {
        throw Exception('Error fetching user profile');
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  Future<Map<String, dynamic>> updateUserProfile(UpdateProfileModel updateProfileModel) async {
    try {
      String? accessToken = await TLocalStorage.getString('access_token');
      String? userId = await TLocalStorage.getString('id');
      bool hasInternet = await TDeviceUtils.hasInternetConnection();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      if (userId == null) {
        throw Exception('User ID not found');
      }
      // Check for internet connection
      if (!hasInternet) {
        throw Exception('No Internet Connection');
      }
      var request = http.MultipartRequest('PUT', Uri.parse('$_profileUrl/$userId/update/'));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['first_name'] = updateProfileModel.firstName;
      request.fields['last_name'] = updateProfileModel.lastName;
      print('sent firstname: ${updateProfileModel.firstName}');
      print('sent lastname: ${updateProfileModel.lastName}');
      //add image if available
      if (updateProfileModel.image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', updateProfileModel.image!.path));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final updatedProfileData = json.decode(responseData);
        await TLocalStorage.saveString('first_name', updatedProfileData['first_name']);
        await TLocalStorage.saveString('last_name', updatedProfileData['last_name']);
        await TLocalStorage.saveString('image_path', updatedProfileData['image']);
        return updatedProfileData;
        // return json.decode(responseData);
      } else if (response.statusCode == 400) {
        throw Exception('Bad Request Error');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized Error');
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error');
      } else {
        throw Exception('Error updating user profile');
      }
    } catch (e) {
      throw Exception('Error updating user profile: $e');
    }
  }
}
