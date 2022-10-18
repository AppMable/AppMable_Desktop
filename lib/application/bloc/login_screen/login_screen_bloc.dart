import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

@lazySingleton
class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {

  final UserService _userService;
  final LocalStorageService _localStorageService;

  LoginScreenBloc(
    this._userService,
    this._localStorageService,
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
        _localStorageService.write(LoginScreen.userLogged, true);
        event.onLogInSuccess();
      }
    } on LoginException catch (loginException) {
      event.onLogInError(loginException.message);
    } catch (e) {
      event.onLogInError('Algo inesperado ocurrió, vuelve a intentar');
    }
  }
}
