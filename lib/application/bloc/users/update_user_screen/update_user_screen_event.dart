part of 'update_user_screen_bloc.dart';

abstract class UpdateUserScreenEvent extends Equatable {
  const UpdateUserScreenEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserScreenEventLoad extends UpdateUserScreenEvent {
  const UpdateUserScreenEventLoad();
}

class UpdateUserEvent extends UpdateUserScreenEvent {
  final String userId;
  final Map<String, dynamic> user;
  final Function onSuccess;
  final Function(String error) onError;

  const UpdateUserEvent({
    required this.userId,
    required this.user,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
    userId,
    user,
    onSuccess,
    onError,
  ];
}
