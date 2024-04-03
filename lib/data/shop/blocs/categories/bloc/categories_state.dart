part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoryLoading extends CategoriesState {}

final class FetchProductsForCategorySuccess extends CategoriesState {
  final FetchedCategoryItem fetchedCategoryItem;

  const FetchProductsForCategorySuccess(this.fetchedCategoryItem);
}

final class FetchProductsForCategoryFailure extends CategoriesState {
  final String error;

  const FetchProductsForCategoryFailure(this.error);
}

final class FetchCategoriesSuccess extends CategoriesState {
  final List<CategoryItem> categories;

  const FetchCategoriesSuccess(this.categories);

  @override
  List<Object> get props => [];
}

final class FetchCategoriesFailure extends CategoriesState {
  final String error;

  const FetchCategoriesFailure(this.error);
  @override
  List<Object> get props => [];
}

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
