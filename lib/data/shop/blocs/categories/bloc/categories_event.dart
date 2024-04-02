part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends CategoriesEvent {}

class CreateCategoryButtonClickedEvent extends CategoriesEvent {
  final CreateCategoryItem createCategoryItem;

  const CreateCategoryButtonClickedEvent({required this.createCategoryItem});

  @override
  List<Object> get props => [createCategoryItem];
}
