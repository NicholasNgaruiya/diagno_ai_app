// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String email;
  String firstName;
  String lastName;
  String password;
  String password2;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.password2,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        password: json['password'],
        password2: json['password2'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'password2': password2,
      };
  @override
  String toString() {
    return 'UserModel{email: $email, firstName: $firstName, lastName: $lastName, password: $password, password2: $password2}';
  }
}
