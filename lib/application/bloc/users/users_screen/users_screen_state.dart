part of 'users_screen_bloc.dart';

@immutable
abstract class UsersScreenState extends Equatable {
  const UsersScreenState();
}

class UsersScreenInitial extends UsersScreenState {
  const UsersScreenInitial();

  @override
  List<Object> get props => [];
}

class UsersScreenLoading extends UsersScreenInitial {
  const UsersScreenLoading();
}

class UsersScreenLoaded extends UsersScreenState {
  final List<User> users;

  const UsersScreenLoaded({
    required this.users,
  });

  @override
  List<Object> get props => [users];
}