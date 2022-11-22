import 'dart:developer';

import 'package:appmable_desktop/application/bloc/alerts/alerts_screen/alerts_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/alerts/update_alert_screen/update_alert_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/alert_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../domain/model/objects/mock/alert_mock.dart';
import '../../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'update_alert_screen_bloc_test.mocks.dart';

@GenerateMocks([
  AlertsScreenBloc,
  AlertService,
])
void main() {
  final AlertsScreenBloc alertScreenBloc = MockAlertsScreenBloc();
  final AlertService alertService = MockAlertService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final Alert alert = alertMockGenerator();
  final Map<String, dynamic> alertToUpdate = alert.toMap();

  onUpdateSuccess() => log('Success');
  onUpdateError(String error) => log(error);

  group('Update Alert Screen BLoC', () {
    setUp(() {
      alertToUpdate['date_enabled'] = DateFormat("yyyy-MM-dd HH:mm").parse(alertToUpdate['date_enabled']);
      alertToUpdate['date_disabled'] = DateFormat("yyyy-MM-dd HH:mm").parse(alertToUpdate['date_disabled']);
    });

    // UpdateAlertEvent

    blocTest<UpdateAlertScreenBloc, UpdateAlertScreenState>(
      'Success Update',
      setUp: () {
        when(alertService.updateAlert(
          alert: alertToUpdate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      build: () => UpdateAlertScreenBloc(
        alertScreenBloc,
        alertService,
        localStorageService,
      ),
      act: (UpdateAlertScreenBloc bloc) => bloc.add(UpdateAlertEvent(
        userId: userLoginInformation.userId,
        alert: alertToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const AlertUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.updateAlert(
            alert: alertToUpdate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UpdateAlertScreenBloc, UpdateAlertScreenState>(
      'User Update - False',
      setUp: () {
        when(alertService.updateAlert(
          alert: alertToUpdate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => UpdateAlertScreenBloc(
        alertScreenBloc,
        alertService,
        localStorageService,
      ),
      act: (UpdateAlertScreenBloc bloc) => bloc.add(UpdateAlertEvent(
        userId: userLoginInformation.userId,
        alert: alertToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const AlertUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.updateAlert(
            alert: alertToUpdate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UpdateAlertScreenBloc, UpdateAlertScreenState>(
      'User Update - Exception',
      setUp: () {
        when(alertService.updateAlert(
          alert: alertToUpdate,
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => UpdateAlertScreenBloc(
        alertScreenBloc,
        alertService,
        localStorageService,
      ),
      act: (UpdateAlertScreenBloc bloc) => bloc.add(UpdateAlertEvent(
        userId: userLoginInformation.userId,
        alert: alertToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const AlertUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.updateAlert(
            alert: alertToUpdate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
