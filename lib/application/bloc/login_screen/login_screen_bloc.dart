import 'dart:convert';

import 'package:appmable_desktop/application/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/dashboard_screen_super_admin/dashboard_screen_super_admin_bloc.dart';
import 'package:appmable_desktop/domain/exceptions/logout_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:appmable_desktop/domain/services/start_up_router_service.dart';
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
  final StartUpRouterService _startUpRouterService;
  final DashboardScreenBloc _dashboardScreenBloc;
  final DashboardScreenSuperAdminBloc _dashboardScreenSuperAdminBloc;
  final EncrypterService _encrypterService;

  LoginScreenBloc(
    this._userLoginService,
    this._localStorageService,
    this._startUpRouterService,
    this._dashboardScreenBloc,
    this._dashboardScreenSuperAdminBloc,
    this._encrypterService,
  ) : super(const LoginScreenInitial()) {
    on<LogInEvent>(_handleLogin);
    on<LogOutEvent>(_handleLogOut);
    on<LoadLogInScreenEvent>(_handleLoadLogInScreen);
    on<LoadRegisterScreenEvent>(_handleLoadRegisterScreen);
    add(const LoadLogInScreenEvent());
  }

  Future<void> _handleLogin(
    LogInEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    try {
      final UserLoginInformation? userLoginInformation = await _userLoginService.logIn(
        username: event.username,
        password: _encrypterService.encrypt(event.password),
      );

      if (userLoginInformation != null) {
        await _localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());
        final String routeName = await _startUpRouterService.execute();

        event.onLogInSuccess(routeName);
        emit(const UserLogged());
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
        _localStorageService.remove(LoginScreen.userLoginInformation);
        _dashboardScreenBloc.add(const DashboardScreenEventReset());
        _dashboardScreenSuperAdminBloc.add(const DashboardScreenSuperAdminEventReset());
        event.onLogOutSuccess();
        emit(const LoginScreenLoaded());
      } else {
        event.onLogOutError('Algo inesperado ocurrió, vuelve a intentar');
      }
    } on LogOutException catch (logOutException) {
      event.onLogOutError(logOutException.message);
    } catch (e) {
      event.onLogOutError('Algo inesperado ocurrió, vuelve a intentar');
    }
  }

  void _handleLoadLogInScreen(
    LoadLogInScreenEvent event,
    Emitter<LoginScreenState> emit,
  ) {
    emit(const LoginScreenLoaded());
  }

  void _handleLoadRegisterScreen(
    LoadRegisterScreenEvent event,
    Emitter<LoginScreenState> emit,
  ) {
    emit(const RegisterScreenLoaded());
  }
}
