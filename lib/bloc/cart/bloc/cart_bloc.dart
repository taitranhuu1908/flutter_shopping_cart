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
    on<ClearCartEvent>(_clearCart);
  }

  void _handleRemoveCart(RemoveCartEvent event, Emitter<ListCartState> emit) {
    final state = this.state;
    List<Cart> carts = state.carts;
    int index =
        carts.indexWhere((item) => item.product!.id == event.product.id);
    carts.removeAt(index);
    if (carts.isEmpty) {
      carts = const <Cart>[];
    }
    ListCartState listCartState = ListCartState(carts: carts);
    listCartState.totalPrice = totalPrice(carts);
    emit(listCartState);
  }

  void _handleAddCart(AddCartEvent event, Emitter<ListCartState> emit) {
    final state = this.state;
    List<Cart> carts = state.carts.isNotEmpty ? List.from(state.carts) : [];
    int index =
        carts.indexWhere((item) => item.product!.id == event.cart.product!.id);
    if (index == -1) {
      carts.insert(0, event.cart);
    } else {
      Cart cart = carts[index];
      int quantityCurrent = cart.quantity!;
      cart.quantity = quantityCurrent + 1;
      carts[index] = cart;
    }

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

  void _clearCart(ClearCartEvent event, Emitter<ListCartState> emit) {
    ListCartState listCartState = ListCartState(carts: const <Cart>[]);
    listCartState.totalPrice = 0;
    emit(listCartState);
  }
}
