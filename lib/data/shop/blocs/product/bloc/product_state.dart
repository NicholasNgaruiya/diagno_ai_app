part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class AddProductLoading extends ProductState {}

final class AddProductSuccess extends ProductState {
  final Map<String, dynamic> response;
  const AddProductSuccess(this.response);

  @override
  List<Object> get props => [response];
}

final class AddProductFailure extends ProductState {
  final String error;
  const AddProductFailure(this.error);

  @override
  List<Object> get props => [error];
}
