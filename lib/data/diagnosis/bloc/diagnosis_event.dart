part of 'diagnosis_bloc.dart';

abstract class DiagnosisEvent extends Equatable {
  const DiagnosisEvent();

  @override
  List<Object> get props => [];
}

class PredictButtonClickedEvent extends DiagnosisEvent {
  final String symptoms;

  const PredictButtonClickedEvent({required this.symptoms});

  @override
  List<Object> get props => [symptoms];
}
