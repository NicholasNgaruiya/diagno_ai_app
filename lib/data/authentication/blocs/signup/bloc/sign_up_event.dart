part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonClickedEvent extends SignUpEvent {
  final UserModel user;

  const SignUpButtonClickedEvent(this.user);

  @override
  List<Object> get props => [user];
}
