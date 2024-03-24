import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../repositories/auth_repository.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<VerifyEmailButtonClickedEvent>(verifyEmailButtonClickedEvent);
  }

  FutureOr<void> verifyEmailButtonClickedEvent(VerifyEmailButtonClickedEvent event, Emitter<VerifyEmailState> emit) async {
    emit(VerifyEmailLoadingState());

    try {
      final response = await AuthRepository.verifyEmail(event.otp);
      emit(VerifyEmailSuccessState(response));
    } catch (error) {
      emit(VerifyEmailErrorState(error));
    }
  }
}
