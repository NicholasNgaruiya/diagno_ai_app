import 'package:restaurant_frontend/features/authentication/models/user_model.dart';
import 'package:restaurant_frontend/utils/http/http_client.dart';

class AuthService {
  //register user using http_client
  static const String _baseUrl = 'auth';

  //Method to signup
  static Future<Map<String, dynamic>> signUp(UserModel user) async {
    final data = user.toJson();

    return await THttHelper.post('$_baseUrl/register/', data);
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
}
