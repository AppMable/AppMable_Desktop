import 'dart:convert';

import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
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

  DashboardScreenBloc(
    this._localStorageService,
  ) : super(const DashboardScreenInitial()) {
    on<DashboardScreenEventLoad>(_handleLoad);
    add(const DashboardScreenEventLoad());
  }

  Future<void> _handleLoad(
    DashboardScreenEventLoad event,
    Emitter<DashboardScreenState> emit,
  ) async {
    emit(const DashboardScreenLoading());

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userInformation)));

    emit(DashboardScreenLoaded(userLoginInformation: userLoginInformation));
  }
}
