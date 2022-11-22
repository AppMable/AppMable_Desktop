import 'dart:developer';

import 'package:appmable_desktop/application/bloc/alerts/alerts_screen/alerts_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/alerts/create_alert_screen/create_alert_screen_bloc.dart';
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
import 'create_alert_screen_bloc_test.mocks.dart';

@GenerateMocks([
  AlertsScreenBloc,
  AlertService,
])
void main() {
  final AlertsScreenBloc alertsScreenBloc = MockAlertsScreenBloc();
  final AlertService alertService = MockAlertService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final Alert alert = alertMockGenerator();
  final Map<String, dynamic> alertToCreate = alert.toMap();


  onCreateSuccess() => log('Success');
  onCreateError(String error) => log(error);

  group('Create Alert Screen BLoC', () {

    setUp(() {
      alertToCreate['date_enabled'] = DateFormat("yyyy-MM-dd HH:mm").parse(alertToCreate['date_enabled']);
      alertToCreate['date_disabled'] = DateFormat("yyyy-MM-dd HH:mm").parse(alertToCreate['date_disabled']);
    });

    // Create
    blocTest<CreateAlertScreenBloc, CreateAlertScreenState>(
      'Success Create',
      setUp: () {
        when(alertService.createAlert(
          alert: alertToCreate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      build: () => CreateAlertScreenBloc(
        alertsScreenBloc,
        alertService,
        localStorageService,
      ),
      act: (CreateAlertScreenBloc bloc) => bloc.add(CreateAlertEvent(
        userId: userLoginInformation.userId,
        alert: alertToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [
        const AlertCreated(),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.createAlert(
            alert: alertToCreate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<CreateAlertScreenBloc, CreateAlertScreenState>(
      'User Create - false',
      setUp: () {
        when(alertService.createAlert(
          alert: alertToCreate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => CreateAlertScreenBloc(
        alertsScreenBloc,
        alertService,
        localStorageService,
      ),
      act: (CreateAlertScreenBloc bloc) => bloc.add(CreateAlertEvent(
        userId: userLoginInformation.userId,
        alert: alertToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [],
      verify: (_) {
        verifyInOrder([
          alertService.createAlert(
            alert: alertToCreate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<CreateAlertScreenBloc, CreateAlertScreenState>(
      'User Create - Exception',
      setUp: () {
        when(alertService.createAlert(
          alert: alertToCreate,
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => CreateAlertScreenBloc(
        alertsScreenBloc,
        alertService,
        localStorageService,
      ),
      act: (CreateAlertScreenBloc bloc) => bloc.add(CreateAlertEvent(
        userId: userLoginInformation.userId,
        alert: alertToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [],
      verify: (_) {
        verifyInOrder([
          alertService.createAlert(
            alert: alertToCreate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
