part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends UserEvent {
  String username;
  String password;

  UserLoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
