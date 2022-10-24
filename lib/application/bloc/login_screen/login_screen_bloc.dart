import 'dart:convert';

import 'package:appmable_desktop/domain/exceptions/logout_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_login_service.dart';
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
  final UserLoginService _userLoginService;
  final LocalStorageService _localStorageService;

  LoginScreenBloc(
    this._userLoginService,
    this._localStorageService,
  ) : super(const LoginScreenInitial()) {
    on<LogInEvent>(_handleLogin);
    on<LogOutEvent>(_handleLogOut);
  }

  Future<void> _handleLogin(
    LogInEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    try {
      final UserLoginInformation? userLoginInformation = await _userLoginService.logIn(
        username: event.username,
        password: event.password,
      );

      if (userLoginInformation != null) {
        emit(const UserLogged());
        _localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());
        event.onLogInSuccess();
      } else {
        event.onLogInError('Algo inesperado ocurrió, vuelve a intentar');
      }
    } on LoginException catch (loginException) {
      event.onLogInError(loginException.message);
    } catch (e) {
      event.onLogInError('Algo inesperado ocurrió, vuelve a intentar');
    }
  }

  Future<void> _handleLogOut(
    LogOutEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    try {
      if (await _userLoginService.logOut(userToken: userLoginInformation.userToken)) {
        emit(const UserLoggedOut());
        _localStorageService.remove(LoginScreen.userLoginInformation);
        event.onLogOutSuccess();
      } else {
        event.onLogOutError('Algo inesperado ocurrió, vuelve a intentar');
      }
    } on LogOutException catch (logOutException) {
      event.onLogOutError(logOutException.message);
    } catch (e) {
      event.onLogOutError('Algo inesperado ocurrió, vuelve a intentar');
    }
  }
}
