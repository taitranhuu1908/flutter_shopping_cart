part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [ListCartState];
}

class ListCartState extends CartState {
  List<Product> carts;

  ListCartState({this.carts = const <Product>[]});

  @override
  List<Object> get props => [carts];
}
