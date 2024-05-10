import 'dart:io';

class UpdateProfileModel {
  final String id;
  final String email;
  final File? image;
  final String firstName;
  final String lastName;

  UpdateProfileModel({required this.id, required this.email, this.image, required this.firstName, required this.lastName});

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      id: json['id'],
      email: json['email'],
      image: json['image'] != null ? File(json['image']) : null,
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
