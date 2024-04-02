import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:restaurant_frontend/features/shop/admin/models/category_item.dart';
import 'package:restaurant_frontend/features/shop/admin/models/update_category_item.dart';

import '../../../../repositories/admin_repository.dart';

part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  final CategoryItem categoryItem;
  CategoryDetailsBloc(this.categoryItem) : super(CategoryDetailsInitial(categoryItem)) {
    on<EditButtonClickedEvent>(editButtonClickedEvent);
    on<SaveButtonClickedEvent>(saveButtonClickedEvent);
    on<DeleteButtonClickedEvent>(deleteButtonClickedEvent);
  }

  FutureOr<void> editButtonClickedEvent(EditButtonClickedEvent event, Emitter<CategoryDetailsState> emit) {
    emit(ModelSwitchedState()); //mean't to display a scaffold messenger
    emit(CategoryDetailsEditing(categoryItem));
  }

  FutureOr<void> saveButtonClickedEvent(SaveButtonClickedEvent event, Emitter<CategoryDetailsState> emit) async {
    emit(CategoryDetailsLoadingState());
    final updateCategoryItem = event.updateCategoryItem;
    try {
      final response = await AdminRepository().updateCategory(updateCategoryItem);
      emit(SaveSuccessState('Category updated successfully'));
      print('Save sucess state response: $response');
    } catch (e) {
      emit(SaveFailedState('Failed to update category'));
    }
  }

  FutureOr<void> deleteButtonClickedEvent(DeleteButtonClickedEvent event, Emitter<CategoryDetailsState> emit) async {
    //Handle deleting logic here
    emit(CategoryDetailsLoadingState());
    try {
      await AdminRepository().deleteCategory(event.categoryId);
      emit(DeletedCategorySuccessState('Category deleted successfully'));
    } catch (e) {
      emit(DeletedCategoryFailureState('Failed to delete category'));
    }
  }
}
