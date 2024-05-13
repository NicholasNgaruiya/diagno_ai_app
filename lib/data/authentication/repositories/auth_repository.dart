import '../../../features/authentication/models/user_model.dart';
import '../../../features/profile/models/update_profile_model.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../services/auth_service.dart';

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

  //Method to reset password
  static Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      final response = await AuthService.resetPassword(email);
      //Handle the response here if necessary
      return response;
    } catch (error) {
      //Handle errors if any
      print('Error resetting password: $error');
      rethrow;
    }
  }

  //Method to login in with email and password
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await AuthService.signIn(email, password);

      //Extract full name and split into first name and last name
      final fullName = response['full_name'] as String;
      final List<String> nameParts = fullName.split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts.first : '';
      final lastName = nameParts.length > 1 ? nameParts.last : '';
      //Save email and password to local storage
      await TLocalStorage.saveString('email', email);
      await TLocalStorage.saveString('password', password);

      // await _saveAccessToken(response['access_token']);
      await TLocalStorage.saveString('access_token', response['access_token']);
      // await _saveAccessToken(response['access_token']);
      //save user id  and name
      await TLocalStorage.saveString('id', response['id']);
      await TLocalStorage.saveString('user_name', response['full_name']);
      await TLocalStorage.saveString('image_path', response['image']);
      await TLocalStorage.saveString('first_name', firstName);
      await TLocalStorage.saveString('last_name', lastName);
      print('Access Token: ${response['access_token']}');
      print('User id: ${response['id']}');
      print('User id: ${response['full_name']}');

      return response;
    } catch (error) {
      print('Error logging in: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await AuthService().getUserProfile();
      //Handle the response here if necessary
      return response;
    } catch (error) {
      //Handle errors if any
      print('Error getting user profile: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateUserProfile(UpdateProfileModel updateProfileModel) async {
    try {
      final response = await AuthService().updateUserProfile(updateProfileModel);
      //Handle the response here if necessary
      return response;
    } catch (error) {
      //Handle errors if any
      print('Error updating user profile: $error');
      rethrow;
    }
  }
}
