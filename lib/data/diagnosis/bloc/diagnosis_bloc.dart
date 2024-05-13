import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/diagnosis_repository.dart';

part 'diagnosis_event.dart';
part 'diagnosis_state.dart';

class DiagnosisBloc extends Bloc<DiagnosisEvent, DiagnosisState> {
  DiagnosisBloc() : super(DiagnosisInitial()) {
    on<PredictButtonClickedEvent>(predictButtonClickedEvent);
  }

  FutureOr<void> predictButtonClickedEvent(PredictButtonClickedEvent event, Emitter<DiagnosisState> emit) async {
    emit(GetDiagnosisLoading());
    try {
      final response = await DiagnosisRepository().getDiagnosis(event.symptoms);
      emit(GetDiagnosisSuccess(response));
    } catch (e) {
      print(e);
      emit(const GetDiagnosisFailure('Failed to get diagnosis. Please try again.'));
    }
  }
}
