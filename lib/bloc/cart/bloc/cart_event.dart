part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddCartEvent extends CartEvent {
  Product product;

  AddCartEvent(this.product);

  @override
  List<Object> get props => [product];
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
