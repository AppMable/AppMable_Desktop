part of 'create_user_screen_bloc.dart';

@immutable
abstract class CreateUserScreenState extends Equatable {
  const CreateUserScreenState();
}

class CreateUserScreenInitial extends CreateUserScreenState {
  const CreateUserScreenInitial();

  @override
  List<Object> get props => [];
}

class UserCreated extends CreateUserScreenInitial {
  const UserCreated();
}

class UserAdminCreated extends CreateUserScreenInitial {
  const UserAdminCreated();
}