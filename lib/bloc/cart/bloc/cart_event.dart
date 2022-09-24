part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddCartEvent extends CartEvent {
  Cart cart;

  AddCartEvent(this.cart);

  @override
  List<Object> get props => [cart];
}

class RemoveCartEvent extends CartEvent {
  int index;

  RemoveCartEvent(this.index);

  @override
  List<Object> get props => [index];
}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();

  @override
  List<Object> get props => [];
}
