import 'dart:convert';
import 'dart:typed_data';

import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/domain/exceptions/logout_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:appmable_desktop/infrastructure/repositories/user/http_user_repository.dart';

import '../../../domain/model/value_objects/mock/barcode_search_result_mock.dart';
import 'http_user_repository_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group('Tests over User Repository', () {
    final Faker faker = Faker();
    final HttpService httpService = MockHttpService();
    final HttpUserRepository repository = HttpUserRepository(httpService);

    final String username = faker.lorem.words(1).join('');
    final String password = faker.lorem.words(1).join('');
    final String urlLogin =
        HttpUserRepository.urlUserLogin.replaceAll('<username>', username).replaceAll('<password>', password);

    final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
    final String userToken = userLoginInformation.userToken;
    final String urlLogout = HttpUserRepository.urlUserLogOut.replaceAll('<userToken>', userToken);

    // Log In

    test('Login OK', () async {
      when(httpService.get(Uri.parse(urlLogin))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getUserLoginHttpStringFromUserLoginInformation(userLoginInformation),
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(await repository.logIn(username: username, password: password), userLoginInformation);
    });

    test('Login KO - Http Code is 403', () async {
      when(httpService.get(Uri.parse(urlLogin))).thenAnswer(
        (_) => Future.value(
          Response(
            body: jsonEncode(faker.lorem.words(1).join('')),
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(
              [
                91,
                34,
                67,
                111,
                110,
                116,
                114,
                97,
                115,
                101,
                110,
                121,
                97,
                32,
                105,
                110,
                99,
                111,
                114,
                114,
                101,
                99,
                116,
                97,
                34,
                93
              ],
            ),
          ),
        ),
      );

      expect(
        () async => await repository.logIn(username: username, password: password),
        throwsA(
          predicate((e) => e is LoginException),
        ),
      );
    });

    test('Login KO - Http Code is 400', () async {
      when(httpService.get(Uri.parse(urlLogin))).thenAnswer(
        (_) => Future.value(
          Response(
            body: jsonEncode(faker.lorem.words(1).join('')),
            statusCode: 400,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(await repository.logIn(username: username, password: password), null);
    });

    // Log Out

    test('LogOut OK', () async {
      when(httpService.get(Uri.parse(urlLogout))).thenAnswer(
        (_) => Future.value(
          Response(
            body: jsonEncode(faker.lorem.words(1).join('')),
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(await repository.logOut(userToken: userToken), true);
    });

    test('LogOut KO - Http Code is 403', () async {
      when(httpService.get(Uri.parse(urlLogout))).thenAnswer(
        (_) => Future.value(
          Response(
            body: jsonEncode(faker.lorem.words(1).join('')),
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
        () async => await repository.logOut(userToken: userToken),
        throwsA(
          predicate((e) => e is LogOutException),
        ),
      );
    });

    test('LogOut KO - Http Code is 400', () async {
      when(httpService.get(Uri.parse(urlLogout))).thenAnswer(
        (_) => Future.value(
          Response(
            body: jsonEncode(faker.lorem.words(1).join('')),
            statusCode: 400,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(await repository.logOut(userToken: userToken), false);
    });
  });
}
