part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class LoadingState extends HomeState {}

final class QuotesLoadedState extends HomeState {
  final String text;
  final String author;

  const QuotesLoadedState({required this.text, required this.author});
}

final class QuotesErrorLoadingState extends HomeState {
  final String error;

  const QuotesErrorLoadingState({required this.error});
}
