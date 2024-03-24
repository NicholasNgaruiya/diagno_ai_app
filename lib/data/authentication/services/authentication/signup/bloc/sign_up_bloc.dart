import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_frontend/data/authentication/repositories/auth_repository.dart';

import '../../../../../../features/authentication/models/user_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
  }

  FutureOr<void> signUpButtonClickedEvent(SignUpButtonClickedEvent event, Emitter<SignUpState> emit) async {
    print('UserModel: ${event.user}');
    emit(SignUpLoadingState());

    try {
      final response = await AuthRepository.signUpUSer(event.user);
      emit(SignUpSuccessState(response));
    } catch (error) {
      emit(SignUpErrorState(error));
    }
  }
}