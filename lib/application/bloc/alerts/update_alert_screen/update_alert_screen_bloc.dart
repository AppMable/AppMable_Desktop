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
import 'package:intl/intl.dart';

part 'update_alert_screen_event.dart';
part 'update_alert_screen_state.dart';

@lazySingleton
class UpdateAlertScreenBloc extends Bloc<UpdateAlertScreenEvent, UpdateAlertScreenState> {
  final AlertsScreenBloc _alertsScreenBloc;
  final AlertService _alertService;
  final LocalStorageService _localStorageService;

  UpdateAlertScreenBloc(
    this._alertsScreenBloc,
    this._alertService,
    this._localStorageService,
  ) : super(const UpdateAlertScreenInitial()) {
    on<UpdateAlertEvent>(_handleUpdateAlert);
  }

  Future<void> _handleUpdateAlert(
    UpdateAlertEvent event,
    Emitter<UpdateAlertScreenState> emit,
  ) async {
    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    if (event.alert['date_enabled'] != null) {
      event.alert['date_enabled'] = DateFormat('yyyy-MM-dd HH:mm').format(event.alert['date_enabled']);
    }

    if (event.alert['date_disabled'] != null) {
      event.alert['date_disabled'] = DateFormat('yyyy-MM-dd HH:mm').format(event.alert['date_disabled']);
    }

    try {
      if (await _alertService.updateAlert(
        alert: event.alert,
        userToken: userLoginInformation.userToken,
      )) {
        _alertsScreenBloc.add(AlertsScreenEventLoad(userId: event.userId));
        event.onSuccess();
      } else {
        event.onError('No se ha modificar el usuario');
      }
    } catch (_) {
      event.onError('No se ha podido modificar el usuario');
    }

    emit(const AlertUpdated());
  }
}
