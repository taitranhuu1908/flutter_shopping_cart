import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(ListCartState()) {
    on<AddCartEvent>((event, emit) {
      final state = ListCartState();
      emit(ListCartState(
          carts: List.from(state.carts)..insert(0, event.product)));
    });
    on<RemoveCartEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ClearCartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
