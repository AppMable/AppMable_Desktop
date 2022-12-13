import 'dart:convert';

import 'package:appmable_desktop/application/bloc/user_info/user_info_bloc.dart';
import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_screen_super_admin_event.dart';
part 'dashboard_screen_super_admin_state.dart';

@lazySingleton
class DashboardScreenSuperAdminBloc extends Bloc<DashboardScreenSuperAdminEvent, DashboardScreenSuperAdminState> {
  final LocalStorageService _localStorageService;
  final UserService _userService;
  final UserInfoBloc _userInfoBloc;

  DashboardScreenSuperAdminBloc(
    this._localStorageService,
    this._userService,
    this._userInfoBloc,
  ) : super(const DashboardScreenSuperAdminInitial()) {
    on<DashboardScreenSuperAdminEventLoad>(_handleLoad);
    on<DashboardScreenSuperAdminEventReset>(_handleReset);
  }

  Future<void> _handleLoad(
    DashboardScreenSuperAdminEventLoad event,
    Emitter<DashboardScreenSuperAdminState> emit,
  ) async {
    emit(const DashboardScreenSuperAdminLoading());
    await Future.delayed(Duration(milliseconds: Config.defaultDelay), () {});

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(await _localStorageService.read(LoginScreen.userLoginInformation)));

    final User? user = await _userService.getUser(
      userId: userLoginInformation.userId,
      userToken: userLoginInformation.userToken,
    );

    if (user != null) {
      _localStorageService.write(UserInfo.userInformation, user.toJson());
      _userInfoBloc.add(UserInfoEventLoad(user: user));
    }

    emit(const DashboardScreenSuperAdminLoaded());
  }

  void _handleReset(
    DashboardScreenSuperAdminEventReset event,
    Emitter<DashboardScreenSuperAdminState> emit,
  ) {
    emit(const DashboardScreenSuperAdminInitial());
  }
}
