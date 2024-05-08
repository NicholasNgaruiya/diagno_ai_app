import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_frontend/features/profile/models/fetch_profile_model.dart';
import 'package:restaurant_frontend/features/profile/models/update_profile_model.dart';

import '../../../../../features/profile/models/user_profile_model.dart';
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
      final userProfileData = await AuthRepository().getUserProfile();
      final userProfile = FetchProfileModel.fromJson(userProfileData);
      emit(UserProfileLoaded(userProfile));
    } catch (e) {
      print(e);
      emit(UserProfileError('Failed to load user profile: $e'));
    }
  }

  FutureOr<void> updateUserProfile(UpdateUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      final updateProfileData = await AuthRepository().updateUserProfile(event.updateProfileModel);
      final updateProfile = UpdateProfileModel.fromJson(updateProfileData);
      emit(UserProfileUpdated(updateProfileModel: updateProfile));
    } catch (e) {
      print(e);
      emit(UserProfileError('Failed to update user profile: $e'));
    }
  }
}
