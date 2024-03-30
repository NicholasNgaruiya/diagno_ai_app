import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_frontend/data/shop/repositories/admin_repository.dart';
import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';

part 'product_event.dart';
part 'product_state.dart';
//TODO: To create a product i need the authorization token
//TODO: I also need the Categories to be displayed in the dropdown because the post request request the uuid of the category to make the request

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AdminRepository _adminRepository;
  ProductBloc(this._adminRepository) : super(ProductInitial()) {
    on<CreateProductButtonClickedEvent>(createProductButtonClickedEvent);
  }

  FutureOr<void> createProductButtonClickedEvent(CreateProductButtonClickedEvent event, Emitter<ProductState> emit) async {
    emit(AddProductLoading());
    try {
      final response = await _adminRepository.createProduct(event.productItem);
      emit(AddProductSuccess(response));
    } catch (e) {
      emit(AddProductFailure('Failed to create product: $e'));
    }
  }
}
