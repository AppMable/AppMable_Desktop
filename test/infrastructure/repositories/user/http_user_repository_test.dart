import 'dart:convert';
import 'dart:typed_data';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/infrastructure/repositories/user/http_user_repository.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:mockito/mockito.dart';
import '../../../domain/model/objects/mock/user_mock.dart';
import 'http_user_repository_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group('Tests over User Repository', () {
    final Faker faker = Faker();
    final HttpService httpService = MockHttpService();
    final HttpUserRepository repository = HttpUserRepository(httpService);

    // Read All Users

    /*
    test('readAllUsers - OK', () async {
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
    */

    // Get User

    // Delete User

    test('Delete User - OK', () async {
      final String userId = faker.randomGenerator.integer(5).toString();
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userId)
          .replaceAll('<userType>', userType)
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
          await repository.deleteUser(
            userId: userId,
            userType: userType,
            userToken: userToken,
          ),
          true);
    });

    test('Delete User - KO', () async {
      final String userId = faker.randomGenerator.integer(5).toString();
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userId)
          .replaceAll('<userType>', userType)
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
          await repository.deleteUser(
            userId: userId,
            userType: userType,
            userToken: userToken,
          ),
          false);
    });

    // Create User

    test('Create User - OK', () async {
      final User user = userMockGenerator();
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String url =
          HttpUserRepository.urlGetAllUsers.replaceAll('<userType>', userType).replaceAll('<userToken>', userToken);

      when(httpService.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toMap()),
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
          await repository.createUser(
            user: user.toMap(),
            userType: userType,
            userToken: userToken,
          ),
          true);
    });

    test('Create User - KO', () async {
      final User user = userMockGenerator();
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String url =
          HttpUserRepository.urlGetAllUsers.replaceAll('<userType>', userType).replaceAll('<userToken>', userToken);

      when(httpService.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toMap()),
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
          await repository.createUser(
            user: user.toMap(),
            userType: userType,
            userToken: userToken,
          ),
          false);
    });

    // Update User

    test('Update User - OK', () async {
      final User user = userMockGenerator();
      final String userId = user.id.toString();
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userId)
          .replaceAll('<userType>', userType)
          .replaceAll('<userToken>', userToken);

      when(httpService.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toMap()),
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
          await repository.updateUser(
            user: user.toMap(),
            userType: userType,
            userToken: userToken,
          ),
          true);
    });

    test('Create User - KO', () async {
      final User user = userMockGenerator();
      final String userId = user.id.toString();
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userId)
          .replaceAll('<userType>', userType)
          .replaceAll('<userToken>', userToken);

      when(httpService.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toMap()),
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
          await repository.updateUser(
            user: user.toMap(),
            userType: userType,
            userToken: userToken,
          ),
          false);
    });
  });
}
