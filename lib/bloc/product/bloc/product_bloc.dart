import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/services/product_service.dart';

import '../../../model/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService;
  ProductBloc(this._productService) : super(ListProductLoadingState()) {
    on<FindAllProductEvent>(((event, emit) async {
      List<Product> products = await _productService.getListProduct();
      emit(ListProductState(products: products));
    }));
  }
}
