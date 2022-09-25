part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  User user;

  UserInitial({required this.user});

  @override
  List<Object> get props => [user];
}
