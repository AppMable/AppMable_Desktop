part of 'login_screen_bloc.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadLogInScreen extends LoginScreenEvent {
  const LoadLogInScreen();
}

class LogInEvent extends LoginScreenEvent {
  final String username;
  final String password;
  final Function(String routeName) onLogInSuccess;
  final Function(String error) onLogInError;

  const LogInEvent({
    required this.username,
    required this.password,
    required this.onLogInSuccess,
    required this.onLogInError,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        onLogInSuccess,
        onLogInError,
      ];
}

class LogOutEvent extends LoginScreenEvent {
  final Function onLogOutSuccess;
  final Function(String error) onLogOutError;

  const LogOutEvent({
    required this.onLogOutSuccess,
    required this.onLogOutError,
  });

  @override
  List<Object?> get props => [
    onLogOutSuccess,
    onLogOutError,
  ];
}

class LoadLogInScreenEvent extends LoginScreenEvent {
  const LoadLogInScreenEvent();
}

class LoadRegisterScreenEvent extends LoginScreenEvent {
  const LoadRegisterScreenEvent();
}