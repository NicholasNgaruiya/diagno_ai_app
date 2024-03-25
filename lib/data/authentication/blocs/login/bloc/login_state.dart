part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final Map<String, dynamic> response;

  LoginSuccessState(this.response);
}

final class LoginErrorState extends LoginState {
  final dynamic error;

  LoginErrorState(this.error);
}
