part of 'login_screen_bloc.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadLogInScreen extends LoginScreenEvent {
  const LoadLogInScreen();
}

class LoadLogOutScreen extends LoginScreenEvent {
  const LoadLogOutScreen();
}

class LogOutEvent extends LoginScreenEvent {
  final String username;
  final String password;
  final Function onLogOutSuccess;

  const LogOutEvent({
    required this.username,
    required this.password,
    required this.onLogOutSuccess,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        onLogOutSuccess,
      ];
}

class LogInEvent extends LoginScreenEvent {
  final String username;
  final String password;
  final Function onLogInSuccess;

  const LogInEvent({
    required this.username,
    required this.password,
    required this.onLogInSuccess,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        onLogInSuccess,
      ];
}