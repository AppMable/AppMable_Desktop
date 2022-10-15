part of 'login_screen_bloc.dart';

@immutable
abstract class LoginScreenState extends Equatable {
  const LoginScreenState();
}

class LoginScreenInitial extends LoginScreenState {
  const LoginScreenInitial();

  @override
  List<Object> get props => [];
}