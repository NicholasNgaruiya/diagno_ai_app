import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../features/shop/admin/models/category_item.dart';
import '../../../../../features/shop/admin/models/create_category_item.dart';
import '../../../../../features/shop/customer/models/fetched_category_item.dart';
import '../../../repositories/admin_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CreateCategoryButtonClickedEvent>(createCategoryButtonClickedEvent);
    on<FetchCategoriesEvent>(fetchCategoriesEvent);
    on<FetchProductsForCategoryEvent>(fetchProductsForCategoryEvent);
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

  FutureOr<void> fetchCategoriesEvent(FetchCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoryLoading());
    try {
      final List<CategoryItem> categories = await AdminRepository().getCategories();
      emit(FetchCategoriesSuccess(categories));
    } catch (e) {
      print(e);
      emit(FetchCategoriesFailure('Failed to load categories: $e'));
    }
  }

  FutureOr<void> fetchProductsForCategoryEvent(FetchProductsForCategoryEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoryLoading());
    try {
      final FetchedCategoryItem fetchedCategoryItems = await AdminRepository().getProductsForCategory(event.categoryId);
      emit(FetchProductsForCategorySuccess(fetchedCategoryItems));
    } catch (e) {
      print(e);
      emit(FetchProductsForCategoryFailure('Failed to load products for category: $e'));
    }
  }
}
