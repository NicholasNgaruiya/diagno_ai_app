part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends CategoriesEvent {
  final CategoryItem categoryItem;
  const FetchCategoriesEvent(this.categoryItem);
}
