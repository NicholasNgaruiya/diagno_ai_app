import 'dart:io';

class FetchProfileModel {
  final String id;
  final String email;
  final String? image;
  final String firstName;
  final String lastName;

  FetchProfileModel({required this.id, required this.email, this.image, required this.firstName, required this.lastName});

  factory FetchProfileModel.fromJson(Map<String, dynamic> json) {
    return FetchProfileModel(
      id: json['id'],
      email: json['email'],
      image: json['image'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
