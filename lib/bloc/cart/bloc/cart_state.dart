part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [ListCartState];
}

class ListCartState extends CartState {
  List<Cart> carts;
  num _totalPrice = 0;

  num get totalPrice => _totalPrice;

  set totalPrice(num price) {
    _totalPrice = price;
  }

  ListCartState({this.carts = const <Cart>[]});

  @override
  List<Object> get props => [carts, totalPrice];
}