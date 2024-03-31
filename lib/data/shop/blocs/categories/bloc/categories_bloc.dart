import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../features/shop/admin/models/category_item.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesLoading()) {
    on<CategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
