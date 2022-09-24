import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';

import '../../../model/product.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, ListCartState> {
  CartBloc() : super(ListCartState()) {
    on<AddCartEvent>(_handleAddCart);
    on<RemoveCartEvent>(_handleRemoveCart);
    on<IncrementQuantityEvent>(_incrementQuantity);
    on<DecrementQuantityEvent>(_decrementQuantity);
  }

  void _handleRemoveCart(RemoveCartEvent event, Emitter<ListCartState> emit) {
    final state = this.state;
    // List<Cart> carts = state.carts.removeAt(event.index);
  }

  void _handleAddCart(AddCartEvent event, Emitter<ListCartState> emit) {
    final state = this.state;
    List<Cart> carts = List.from(state.carts)..insert(0, event.cart);
    ListCartState listCartState = ListCartState(carts: carts);
    listCartState.totalPrice = totalPrice(carts);
    emit(listCartState);
  }

  num totalPrice(List<Cart> carts) {
    num sum = 0;

    for (var item in carts) {
      sum += item.product!.price! * item.quantity!;
    }

    return sum;
  }

  void _decrementQuantity(
      DecrementQuantityEvent event, Emitter<ListCartState> emit) {
    final state = this.state;
    List<Cart> carts = state.carts;
    int index =
        carts.indexWhere((item) => item.product!.id == event.product.id);
    Cart cart = carts[index];
    int quantityCurrent = cart.quantity!;
    if (quantityCurrent <= 1) {
      return;
    }
    cart.quantity = quantityCurrent - 1;
    carts[index] = cart;

    ListCartState listCartState = ListCartState(carts: [...carts]);

    listCartState.totalPrice = totalPrice(carts);
    emit(listCartState);
  }

  void _incrementQuantity(
      IncrementQuantityEvent event, Emitter<ListCartState> emit) {
    final state = this.state;
    List<Cart> carts = state.carts;
    int index =
        carts.indexWhere((item) => item.product!.id == event.product.id);
    Cart cart = carts[index];
    int quantityCurrent = cart.quantity!;

    cart.quantity = quantityCurrent + 1;
    carts[index] = cart;
    ListCartState listCartState = ListCartState(carts: [...carts]);

    listCartState.totalPrice = totalPrice(carts);
    emit(listCartState);
  }
}
