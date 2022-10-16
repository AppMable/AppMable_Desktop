import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

@lazySingleton
class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(const LoginScreenInitial()) {
    on<LogInEvent>(_handleLogin);
  }

  void _handleLogin(
    LogInEvent event,
    Emitter<LoginScreenState> emit,
  ) {
    //emit(const UserLogged());
    event.onLogInSuccess();
  }
}
