part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpButtonClickedEvent extends SignUpEvent {
  final UserModel user;

  SignUpButtonClickedEvent(this.user);
}
