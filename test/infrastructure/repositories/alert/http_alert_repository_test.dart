import 'dart:convert';
import 'dart:typed_data';

import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/infrastructure/repositories/alert/http_alert_repository.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:mockito/mockito.dart';
import '../../../domain/model/objects/mock/alert_mock.dart';
import '../../../domain/model/value_objects/mock/user_login_mock.dart';

import 'http_alert_repository_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group('Tests over Alert Repository', () {
    final Faker faker = Faker();
    final HttpService httpService = MockHttpService();
    final HttpAlertRepository repository = HttpAlertRepository(httpService);

    final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();

    // Read All Alerts

    test('Read All Alerts - OK', () async {
      List<Alert> alertsExpected = List<Alert>.generate(
          faker.randomGenerator.integer(10),
          (int index) => alertMockGenerator(
                id: index,
                idUser: userLoginInformation.userId,
              ));

      final String url =
          HttpAlertRepository.urlListAndCreateAlert.replaceAll('<userToken>', userLoginInformation.userToken);

      final String bodyResponse = getAlertsHttpString(alerts: alertsExpected);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: bodyResponse,
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(utf8.encode(bodyResponse)),
          ),
        ),
      );

      final List<Alert> alertResult = await repository.getAlerts(
        userId: userLoginInformation.userId,
        userToken: userLoginInformation.userToken,
      );

      expect(alertResult, alertsExpected);
    });

    test('Read All Alerts - KO', () async {
      List<User> alertsExpected = [];

      final String url =
          HttpAlertRepository.urlListAndCreateAlert.replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      final List<Alert> alertResult = await repository.getAlerts(
        userId: userLoginInformation.userId,
        userToken: userLoginInformation.userToken,
      );

      expect(alertResult, alertsExpected);
    });

    // Get Alert

    test('Get Alert - OK', () async {

      final int alertId = faker.randomGenerator.integer(10, min: 1);
      Alert alertExpected = alertMockGenerator(id: alertId);

      final String url = HttpAlertRepository.urlDeleteUpdateAlert
          .replaceAll('<alertId>', alertId.toString())
          .replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getAlertHttpString(alertExpected),
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      final Alert? resultAlert = await repository.getAlert(
        alertId: alertId,
        userToken: userLoginInformation.userToken,
      );

      expect(resultAlert, alertExpected);
    });

    test('Get Alert - KO', () async {
      List<Alert> alertsExpected = List<Alert>.generate(
          faker.randomGenerator.integer(10, min: 1),
          (int index) => alertMockGenerator(
                id: index,
                idUser: userLoginInformation.userId,
              ));

      Alert alertExpected = alertMockGenerator(id: alertsExpected.last.id + 1);
      alertsExpected.add(alertExpected);

      final String url = HttpAlertRepository.urlDeleteUpdateAlert
          .replaceAll('<alertId>', alertExpected.id.toString())
          .replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getAlertsHttpString(alerts: alertsExpected),
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500), () {});

      final Alert? resultAlert = await repository.getAlert(
        alertId: alertExpected.id,
        userToken: userLoginInformation.userToken,
      );

      expect(resultAlert, null);
    });

    // Delete Alert

    test('Delete User - OK', () async {
      final int alertId = faker.randomGenerator.integer(5);
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpAlertRepository.urlDeleteUpdateAlert
          .replaceAll('<alertId>', alertId.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.delete(Uri.parse(urlDelete))).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.deleteAlert(
            alertId: alertId,
            userToken: userToken,
          ),
          true);
    });

    test('Delete User - KO', () async {
      final int alertId = faker.randomGenerator.integer(5);
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpAlertRepository.urlDeleteUpdateAlert
          .replaceAll('<alertId>', alertId.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.delete(Uri.parse(urlDelete))).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.deleteAlert(
            alertId: alertId,
            userToken: userToken,
          ),
          false);
    });

    // Create Alert

    test('Create Alert - OK', () async {
      final Alert alert = alertMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpAlertRepository.urlListAndCreateAlert.replaceAll('<userToken>', userToken);

      when(httpService.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(alert.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 201,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.createAlert(
            alert: alert.toMap(),
            userToken: userToken,
          ),
          true);
    });

    test('Create Alert - KO', () async {
      final Alert alert = alertMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpAlertRepository.urlListAndCreateAlert.replaceAll('<userToken>', userToken);

      when(httpService.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(alert.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.createAlert(
            alert: alert.toMap(),
            userToken: userToken,
          ),
          false);
    });

    // Update Alert

    test('Update Alert - OK', () async {
      final Alert alert = alertMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpAlertRepository.urlDeleteUpdateAlert
          .replaceAll('<alertId>', alert.id.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(alert.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.updateAlert(
            alert: alert.toMap(),
            userToken: userToken,
          ),
          true);
    });

    test('Update Alert - KO', () async {
      final Alert alert = alertMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpAlertRepository.urlDeleteUpdateAlert
          .replaceAll('<alertId>', alert.id.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(alert.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.updateAlert(
            alert: alert.toMap(),
            userToken: userToken,
          ),
          false);
    });
  });
}
