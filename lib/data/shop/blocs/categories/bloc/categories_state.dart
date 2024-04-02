part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoryLoading extends CategoriesState {}

final class CreateCategorySuccess extends CategoriesState {
  final Map<String, dynamic> response;

  const CreateCategorySuccess(this.response);
  @override
  List<Object> get props => [response];
}

final class CreateCategoryFailure extends CategoriesState {
  final String error;

  const CreateCategoryFailure(this.error);
  @override
  List<Object> get props => [error];
}

final class DeleteCategorySuccess extends CategoriesState {
  final Map<String, dynamic> response;

  const DeleteCategorySuccess(this.response);

  @override
  List<Object> get props => [response];
}

final class DeleteCategoryFailure extends CategoriesState {
  final String error;

  const DeleteCategoryFailure(this.error);
  @override
  List<Object> get props => [error];
}
