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
  Product product;

  RemoveCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();

  @override
  List<Object> get props => [];
}

class IncrementQuantityEvent extends CartEvent {
  Product product;

  IncrementQuantityEvent(this.product);

  @override
  List<Object> get props => [product];
}
class DecrementQuantityEvent extends CartEvent {
  Product product;

  DecrementQuantityEvent(this.product);

  @override
  List<Object> get props => [product];
}

