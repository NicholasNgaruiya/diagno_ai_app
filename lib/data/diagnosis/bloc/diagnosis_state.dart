part of 'diagnosis_bloc.dart';

abstract class DiagnosisState extends Equatable {
  const DiagnosisState();

  @override
  List<Object> get props => [];
}

final class DiagnosisInitial extends DiagnosisState {}

final class GetDiagnosisLoading extends DiagnosisState {}

final class GetDiagnosisSuccess extends DiagnosisState {
  final Map<String, dynamic> diagnosis;

  const GetDiagnosisSuccess(this.diagnosis);

  @override
  List<Object> get props => [diagnosis];
}

final class GetDiagnosisFailure extends DiagnosisState {
  final String message;

  const GetDiagnosisFailure(this.message);

  @override
  List<Object> get props => [message];
}
