import 'dart:convert';

import 'package:appmable_desktop/application/bloc/alerts/alerts_screen/alerts_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/alert_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'create_alert_screen_event.dart';
part 'create_alert_screen_state.dart';

@lazySingleton
class CreateAlertScreenBloc extends Bloc<CreateAlertScreenEvent, CreateAlertScreenState> {
  final AlertsScreenBloc _alertsScreenBloc;
  final AlertService _alertService;
  final LocalStorageService _localStorageService;

  CreateAlertScreenBloc(
    this._alertsScreenBloc,
    this._alertService,
    this._localStorageService,
  ) : super(const CreateAlertScreenInitial()) {
    on<CreateAlertEvent>(_handleCreateAlert);
  }

  Future<void> _handleCreateAlert(
    CreateAlertEvent event,
    Emitter<CreateAlertScreenState> emit,
  ) async {
    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    try {
      if (await _alertService.createAlert(
        alert: event.alert,
        userToken: userLoginInformation.userToken,
      )) {
        _alertsScreenBloc.add(AlertsScreenEventLoad(userId: event.alert['user_id']));
        event.onSuccess();
      } else {
        event.onError('No se ha podido crear el usuario');
      }
    } catch (_) {
      event.onError('No se ha podido crear el usuario');
    }

    emit(const AlertCreated());
  }
}
