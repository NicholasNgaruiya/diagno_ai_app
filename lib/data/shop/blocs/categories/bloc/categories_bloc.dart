import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_frontend/data/shop/repositories/admin_repository.dart';
import 'package:restaurant_frontend/features/shop/admin/models/create_category_item.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CreateCategoryButtonClickedEvent>(createCategoryButtonClickedEvent);
  }

  FutureOr<void> createCategoryButtonClickedEvent(CreateCategoryButtonClickedEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoryLoading());
    try {
      final response = await AdminRepository().createCategory(event.createCategoryItem);
      emit(CreateCategorySuccess(response));
    } catch (e) {
      print(e);
      emit(CreateCategoryFailure('Failed to create category: $e'));
    }
  }
}
