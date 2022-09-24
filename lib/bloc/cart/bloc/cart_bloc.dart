import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, ListCartState> {
  CartBloc() : super(ListCartState()) {
    on<AddCartEvent>(_handleAddCart);
    // on<RemoveCartEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    // on<ClearCartEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  void _handleAddCart(AddCartEvent event, Emitter<ListCartState> emit) {
    final state = this.state;
    emit(
        ListCartState(carts: List.from(state.carts)..insert(0, event.product)));
  }
}
