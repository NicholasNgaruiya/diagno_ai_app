part of 'verify_email_bloc.dart';

sealed class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

final class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoadingState extends VerifyEmailState {}

class VerifyEmailSuccessState extends VerifyEmailState {
  final Map<String, dynamic> response;

  const VerifyEmailSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class VerifyEmailErrorState extends VerifyEmailState {
  final dynamic error;

  const VerifyEmailErrorState(this.error);

  @override
  List<Object> get props => [error];
}
