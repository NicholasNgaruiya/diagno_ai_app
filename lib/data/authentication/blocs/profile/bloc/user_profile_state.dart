part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  final FetchProfileModel fetchProfileModel;

  const UserProfileLoaded(this.fetchProfileModel);

  @override
  List<Object> get props => [fetchProfileModel];
}

class UserProfileUpdated extends UserProfileState {
  final UpdateProfileModel updateProfileModel;

  const UserProfileUpdated({required this.updateProfileModel});
}

final class UserProfileError extends UserProfileState {
  final dynamic message;

  const UserProfileError(this.message);

  @override
  List<Object> get props => [message];
}
