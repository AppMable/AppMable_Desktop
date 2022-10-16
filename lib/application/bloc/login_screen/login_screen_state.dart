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

class LoginScreenLoaded extends LoginScreenInitial {
  const LoginScreenLoaded();
}

class RegisterScreenLoaded extends LoginScreenInitial {
  const RegisterScreenLoaded();
}


class UserLogged extends LoginScreenInitial {
  const UserLogged();
}

class UserLoggedOut extends LoginScreenInitial {
  const UserLoggedOut();
}