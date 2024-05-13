import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/auth_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordButtonClicked>(resetPasswordButtonClicked);
  }

  FutureOr<void> resetPasswordButtonClicked(ResetPasswordButtonClicked event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoadingState());
    try {
      final response = await AuthRepository.resetPassword(event.email);
      emit(ResetPasswordEmailSentState(response: response));
    } catch (error) {
      print(error);
      emit(ResetPasswordFailureState(error: error.toString()));
    }
  }
}
