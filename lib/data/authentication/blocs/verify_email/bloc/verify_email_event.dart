part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class VerifyEmailButtonClickedEvent extends VerifyEmailEvent {
  final String otp;

  const VerifyEmailButtonClickedEvent(this.otp);

  @override
  List<Object> get props => [otp];
}
