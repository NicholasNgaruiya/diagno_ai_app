part of 'reset_password_bloc.dart';

abstract class ResetPasswordState {
  const ResetPasswordState();
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoadingState extends ResetPasswordState {}

final class ResetPasswordEmailSentState extends ResetPasswordState {
  final Map<String, dynamic> response;

  const ResetPasswordEmailSentState({required this.response});
}

final class ResetPasswordFailureState extends ResetPasswordState {
  final String error;

  const ResetPasswordFailureState({required this.error});
}
