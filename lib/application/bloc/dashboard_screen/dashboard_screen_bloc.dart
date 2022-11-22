import 'dart:convert';

import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_screen_event.dart';
part 'dashboard_screen_state.dart';

@lazySingleton
class DashboardScreenBloc extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  final LocalStorageService _localStorageService;
  final UserService _userService;

  DashboardScreenBloc(
    this._localStorageService,
    this._userService,
  ) : super(const DashboardScreenInitial()) {
    on<DashboardScreenEventLoad>(_handleLoad);
    add(const DashboardScreenEventLoad());
  }

  Future<void> _handleLoad(
    DashboardScreenEventLoad event,
    Emitter<DashboardScreenState> emit,
  ) async {
    emit(const DashboardScreenLoading());
    await Future.delayed(Duration(milliseconds: Config.defaultDelay), () {});

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(await _localStorageService.read(LoginScreen.userLoginInformation)));

    final User? user = await _userService.getUser(
      userId: userLoginInformation.userId,
      userToken: userLoginInformation.userToken,
    );

    if(user != null) await _localStorageService.write(DashboardScreen.userInformation, user.toJson());

    emit(const DashboardScreenLoaded());
  }
}
