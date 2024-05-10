import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_frontend/features/profile/models/fetch_profile_model.dart';
import 'package:restaurant_frontend/features/profile/models/update_profile_model.dart';

import '../../../../../utils/local_storage/storage_utility.dart';
import '../../../repositories/auth_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<FetchUserProfile>(fetchUserProfile);
    on<UpdateUserProfile>(updateUserProfile);
  }

  FutureOr<void> fetchUserProfile(FetchUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      // Retrieve user profile data from local storage
      final FetchProfileModel userProfile = await _getUserProfileFromLocalStorage();
      print(
        'User profile looks like this ${userProfile.firstName} ${userProfile.lastName} ${userProfile.email} ${userProfile.image} ${userProfile.id}',
      );

      emit(UserProfileLoaded(userProfile));
    } catch (e) {
      print(e);
      emit(UserProfileError('Failed to load user profile: $e'));
    }
  }

  Future<FetchProfileModel> _getUserProfileFromLocalStorage() async {
    final String? imagePath = await TLocalStorage.getString('image_path');
    final String? firstName = await TLocalStorage.getString('first_name');
    final String? lastName = await TLocalStorage.getString('last_name');

    return FetchProfileModel(
      id: await TLocalStorage.getString('id') ?? '',
      email: await TLocalStorage.getString('email') ?? '',
      image: imagePath,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
    );
  }

  String _capitalizeFirstLetter(String word) {
    return word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
  }

  FutureOr<void> updateUserProfile(UpdateUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      final updateProfileData = await AuthRepository().updateUserProfile(event.updateProfileModel);
      final updateProfile = UpdateProfileModel.fromJson(updateProfileData);
      emit(UserProfileUpdated(updateProfileModel: updateProfile));
    } catch (e) {
      print(e);
      emit(const UserProfileError('Failed to update user profile'));
    }
  }
}
