part of 'update_user_screen_bloc.dart';

@immutable
abstract class UpdateUserScreenState extends Equatable {
  const UpdateUserScreenState();
}

class UpdateUserScreenInitial extends UpdateUserScreenState {
  const UpdateUserScreenInitial();

  @override
  List<Object> get props => [];
}

class UserUpdated extends UpdateUserScreenInitial {
  const UserUpdated();
}