part of 'category_details_bloc.dart';

abstract class CategoryDetailsState {}

class CategoryDetailsInitial extends CategoryDetailsState {
  final CategoryItem categoryItem;

  CategoryDetailsInitial(this.categoryItem);
}

class CategoryDetailsEditing extends CategoryDetailsState {
  final CategoryItem categoryItem;

  CategoryDetailsEditing(this.categoryItem);
}

class CategoryDetailsLoadingState extends CategoryDetailsState {}

class ModelSwitchedState extends CategoryDetailsState {}

class SaveSuccessState extends CategoryDetailsState {
  final String message;

  SaveSuccessState(this.message);
}

class SaveFailedState extends CategoryDetailsState {
  final String message;

  SaveFailedState(this.message);
}

class DeletedCategorySuccessState extends CategoryDetailsState {
  final String message;

  DeletedCategorySuccessState(this.message);
}

class DeletedCategoryFailureState extends CategoryDetailsState {
  final String message;

  DeletedCategoryFailureState(this.message);
}
