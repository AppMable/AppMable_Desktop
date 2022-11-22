import 'dart:developer';

import 'package:appmable_desktop/application/bloc/alerts/alerts_screen/alerts_screen_bloc.dart';
import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/alert_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../domain/model/objects/mock/alert_mock.dart';
import '../../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'alerts_screen_bloc_test.mocks.dart';

@GenerateMocks([
  AlertService,
])
void main() {
  final AlertService alertService = MockAlertService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final Faker faker = Faker();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final int userId = faker.randomGenerator.integer(20);

  List<Alert> alerts =
      List<Alert>.generate(faker.randomGenerator.integer(10), (int index) => alertMockGenerator(idUser: userId));

  onDeleteSuccess() => log('Success');
  onDeleteError(String error) => log(error);

  group('Alerts Screen BLoC', () {
    // AlertScreenEventLoad
    blocTest<AlertsScreenBloc, AlertsScreenState>(
      'Success Load',
      setUp: () {
        when(alertService.getAlerts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(alerts));
      },
      build: () => AlertsScreenBloc(
        alertService,
        localStorageService,
      ),
      expect: () => [],
      verify: (_) {
        verifyInOrder([]);
      },
    );

    blocTest<AlertsScreenBloc, AlertsScreenState>(
      'Success Load - Sending Event',
      setUp: () {
        when(alertService.getAlerts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(alerts));
      },
      wait: Duration(milliseconds: Config.defaultDelay * 2),
      build: () => AlertsScreenBloc(
        alertService,
        localStorageService,
      ),
      act: (AlertsScreenBloc bloc) => bloc.add(AlertsScreenEventLoad(
        userId: userId,
      )),
      expect: () => [
        const AlertsScreenLoading(),
        AlertsScreenLoaded(alerts: alerts),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.getAlerts(
            userId: userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    // AlertsScreenLoadedDeleteEvent

    final int alertIdToDelete = faker.randomGenerator.integer(5);

    blocTest<AlertsScreenBloc, AlertsScreenState>(
      'Success Delete',
      setUp: () {
        when(alertService.getAlerts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(alerts));

        when(alertService.deleteAlert(
          alertId: alertIdToDelete,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      wait: Duration(milliseconds: Config.defaultDelay * 2),
      build: () => AlertsScreenBloc(
        alertService,
        localStorageService,
      ),
      act: (AlertsScreenBloc bloc) => bloc.add(AlertsScreenDeleteEvent(
        alertId: alertIdToDelete,
        userId: userId,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const AlertsScreenLoading(),
        AlertsScreenLoaded(alerts: alerts),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.deleteAlert(
            alertId: alertIdToDelete,
            userToken: userLoginInformation.userToken,
          ),
          alertService.getAlerts(
            userId: userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<AlertsScreenBloc, AlertsScreenState>(
      'Delete - False',
      setUp: () {
        when(alertService.getAlerts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(alerts));

        when(alertService.deleteAlert(
          alertId: alertIdToDelete,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => AlertsScreenBloc(
        alertService,
        localStorageService,
      ),
      act: (AlertsScreenBloc bloc) => bloc.add(AlertsScreenDeleteEvent(
        alertId: alertIdToDelete,
        userId: userId,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const AlertsScreenLoading(),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.deleteAlert(
            alertId: alertIdToDelete,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<AlertsScreenBloc, AlertsScreenState>(
      'Delete - Exception',
      setUp: () {
        when(alertService.getAlerts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(alerts));

        when(alertService.deleteAlert(
          alertId: alertIdToDelete,
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => AlertsScreenBloc(
        alertService,
        localStorageService,
      ),
      act: (AlertsScreenBloc bloc) => bloc.add(AlertsScreenDeleteEvent(
        userId: userId,
        alertId: alertIdToDelete,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const AlertsScreenLoading(),
      ],
      verify: (_) {
        verifyInOrder([
          alertService.deleteAlert(
            alertId: alertIdToDelete,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
