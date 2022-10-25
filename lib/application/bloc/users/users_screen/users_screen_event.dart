part of 'users_screen_bloc.dart';

abstract class UsersScreenEvent extends Equatable {
  const UsersScreenEvent();

  @override
  List<Object?> get props => [];
}

class UsersScreenEventLoad extends UsersScreenEvent {
  const UsersScreenEventLoad();
}

class UsersScreenDeleteEvent extends UsersScreenEvent {
  final String userId;
  final Function onSuccess;
  final Function(String error) onError;

  const UsersScreenDeleteEvent({
    required this.userId,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
    userId,
    onSuccess,
    onError,
  ];
}
