import 'package:restaurant_frontend/data/authentication/services/auth_service.dart';
import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

import '../../../features/authentication/models/user_model.dart';

class AuthRepository {
  //Method to sign up a user
  static Future<Map<String, dynamic>> signUpUSer(UserModel user) async {
    try {
      final response = await AuthService.signUp(user);
      print(response);
      //Handle the response here if necessary
      return response;
    } catch (error) {
      //Handle errors if any
      print('Error registering user: $error');
      rethrow;
    }
  }

  //Method to verify OTP
  static Future<Map<String, dynamic>> verifyEmail(String otp) async {
    try {
      final response = await AuthService.verifyOTP(otp);
      //Handle the response here if necessary
      return response;
    } catch (error) {
      //Handle errors if any
      print('Error verifying OTP: $error');
      rethrow;
    }
  }

  //Method to login in with email and password
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await AuthService.signIn(email, password);
      // await _saveAccessToken(response['access_token']);
      await TLocalStorage.saveString('access_token', response['access_token']);
      print('Access Token: ${response['access_token']}');
      return response;
    } catch (error) {
      print('Error logging in: $error');
      rethrow;
    }
  }

  // static Future<void> _saveAccessToken(String accessToken) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('access_token', accessToken);
  // }
}
