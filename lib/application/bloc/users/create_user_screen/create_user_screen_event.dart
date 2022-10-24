part of 'create_user_screen_bloc.dart';

abstract class CreateUserScreenEvent extends Equatable {
  const CreateUserScreenEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserScreenEventLoad extends CreateUserScreenEvent {
  const CreateUserScreenEventLoad();
}

class CreateUserEvent extends CreateUserScreenEvent {
  final Map<String, dynamic> user;
  final Function onSuccess;
  final Function(String error) onError;

  const CreateUserEvent({
    required this.user,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
    user,
    onSuccess,
    onError,
  ];
}
