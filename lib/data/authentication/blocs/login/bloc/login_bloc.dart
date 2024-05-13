import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      final response = await AuthRepository.login(event.email, event.password);
      emit(LoginSuccessState(response));
    } catch (error) {
      print(error);
      emit(LoginErrorState(error));
    }
  }
}
