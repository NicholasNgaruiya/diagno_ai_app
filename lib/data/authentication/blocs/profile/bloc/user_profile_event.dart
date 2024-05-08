part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserProfileEvent {}

class UpdateUserProfile extends UserProfileEvent {
  final UpdateProfileModel updateProfileModel;

  const UpdateUserProfile(this.updateProfileModel);

  @override
  List<Object> get props => [updateProfileModel];
}
