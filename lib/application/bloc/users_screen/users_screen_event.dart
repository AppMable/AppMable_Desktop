part of 'users_screen_bloc.dart';

abstract class UsersScreenEvent extends Equatable {
  const UsersScreenEvent();
}

class UsersScreenEventLoad extends UsersScreenEvent {
  const UsersScreenEventLoad();

  @override
  List<Object?> get props => [];
}