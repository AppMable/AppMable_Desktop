import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

@lazySingleton
class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final UserService _userService;

  LoginScreenBloc(
    this._userService,
  ) : super(const LoginScreenInitial()) {
    on<LogInEvent>(_handleLogin);
  }

  Future<void> _handleLogin(
    LogInEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    try {
      if (await _userService.logIn(
        username: event.username,
        password: event.password,
      )) {
        emit(const UserLogged());
        event.onLogInSuccess();
      }
    } catch (_) {
      event.onLogInError();
    }
  }
}
