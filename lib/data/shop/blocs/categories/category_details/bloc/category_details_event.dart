part of 'category_details_bloc.dart';

abstract class CategoryDetailsEvent {
  const CategoryDetailsEvent();
}

class EditButtonClickedEvent extends CategoryDetailsEvent {}

class SaveButtonClickedEvent extends CategoryDetailsEvent {
  final UpdateCategoryItem updateCategoryItem;

  const SaveButtonClickedEvent({required this.updateCategoryItem});
}

class DeleteButtonClickedEvent extends CategoryDetailsEvent {
  // final String categoryId;

  DeleteButtonClickedEvent();
}
