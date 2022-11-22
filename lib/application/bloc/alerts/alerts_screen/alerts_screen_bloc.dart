import 'dart:convert';

import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/alert_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'alerts_screen_event.dart';
part 'alerts_screen_state.dart';

@lazySingleton
class AlertsScreenBloc extends Bloc<AlertsScreenEvent, AlertsScreenState> {
  final AlertService _alertService;
  final LocalStorageService _localStorageService;

  AlertsScreenBloc(
    this._alertService,
    this._localStorageService,
  ) : super(const AlertsScreenInitial()) {
    on<AlertsScreenEventLoad>(_handleLoad);
    on<AlertsScreenDeleteEvent>(_handleDeleteAlert);
    on<AlertsScreenEventReset>(_handleReset);
  }

  void _handleReset(
    AlertsScreenEventReset event,
    Emitter<AlertsScreenState> emit,
  ) {
    emit(const AlertsScreenInitial());
  }

  Future<void> _handleLoad(
    AlertsScreenEventLoad event,
    Emitter<AlertsScreenState> emit,
  ) async {
    emit(const AlertsScreenLoading());
    await Future.delayed(Duration(milliseconds: Config.defaultDelay), () {});

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    List<Alert> alerts = await _alertService.getAlerts(
      userId: event.userId,
      userToken: userLoginInformation.userToken,
    );

    emit(AlertsScreenLoaded(alerts: alerts));
  }

  Future<void> _handleDeleteAlert(
    AlertsScreenDeleteEvent event,
    Emitter<AlertsScreenState> emit,
  ) async {
    emit(const AlertsScreenLoading());

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    try {
      if (await _alertService.deleteAlert(
        alertId: event.alertId,
        userToken: userLoginInformation.userToken,
      )) {
        event.onSuccess();
        add(AlertsScreenEventLoad(userId: event.userId));
      } else {
        event.onError('No se ha podido eliminar');
      }
    } catch (_) {
      event.onError('No se ha podido eliminar por algo raro');
    }
  }
}
