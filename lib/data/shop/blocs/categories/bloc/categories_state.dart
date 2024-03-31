part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<CategoryItem> categories;
  const CategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoriesFailure extends CategoriesState {
  final String error;
  const CategoriesFailure(this.error);

  @override
  List<Object> get props => [error];
}
