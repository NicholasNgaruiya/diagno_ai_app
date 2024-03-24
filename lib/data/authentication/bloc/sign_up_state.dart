part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpSuccessState extends SignUpState {
  final Map<String, dynamic> response;

  SignUpSuccessState(this.response);
}

final class SignUpErrorState extends SignUpState {
  final dynamic error;

  SignUpErrorState(this.error);
}
