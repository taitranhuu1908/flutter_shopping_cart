import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopping_cart/services/auth_service.dart';

import '../../../model/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthService _authService = AuthService();
  UserBloc() : super(UserInitial(user: User(username: "", token: ""))) {
    on<UserLoginEvent>(_handleUserLogin);
  }

  void _handleUserLogin(UserLoginEvent event, Emitter<UserState> emit) async {
    User? user = await _authService.login(event.username, event.password);
    if (user != null) {
      emit(UserInitial(user: user));
    }
  }
}
