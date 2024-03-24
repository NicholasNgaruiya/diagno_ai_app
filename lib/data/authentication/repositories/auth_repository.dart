import 'package:restaurant_frontend/data/authentication/services/authentication/auth_service.dart';

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
      throw error;
    }
  }
}
