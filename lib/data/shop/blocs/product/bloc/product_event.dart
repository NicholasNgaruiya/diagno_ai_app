part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class CreateProductButtonClickedEvent extends ProductEvent {
  final ProductItem productItem;

  const CreateProductButtonClickedEvent({required this.productItem});

  @override
  List<Object> get props => [productItem];
}

// final class CategorySelectedEvent extends ProductEvent {
//   final String category;
//   const CategorySelectedEvent(this.category);

//   @override
//   List<Object> get props => [category];
// }

// final class ImageSelectedevent extends ProductEvent {
//   final File image;
//   const ImageSelectedevent(this.image);

//   @override
//   List<Object> get props => [image];
// }
