import 'package:restaurant_frontend/data/authentication/services/auth_service.dart';

import '../../../features/authentication/models/user_model.dart';

class AuthRepository {
  //Method to sign up a user
  static Future<Map<String, dynamic>> signUpUSer(UserModel user) async {
    try {
      final response = await AuthService.signUp(user);
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
      return response;
    } catch (error) {
      print('Error logging in: $error');
      rethrow;
    }
  }
}
