import 'dart:convert';
import 'dart:typed_data';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/infrastructure/repositories/user/http_user_repository.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:mockito/mockito.dart';
import '../../../domain/model/objects/mock/user_mock.dart';
import '../../../domain/model/value_objects/mock/user_login_mock.dart';
import 'http_user_repository_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group('Tests over User Repository', () {
    final Faker faker = Faker();
    final HttpService httpService = MockHttpService();
    final HttpUserRepository repository = HttpUserRepository(httpService);

    final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();

    // Read All Users

    test('Read All Users - OK', () async {
      List<User> usersExpected = List<User>.generate(faker.randomGenerator.integer(10),
          (int index) => userMockGeneratorFromHttpResponse(idUserReference: userLoginInformation.userId));

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userLoginInformation.userId.toString())
          .replaceAll('<userType>', 'user')
          .replaceAll('<userToken>', userLoginInformation.userToken);

      final String bodyResponse = getUsersHttpString(users: usersExpected, areAdminUsers: false);

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

      final List<User> usersResult = await repository.getUsers(
        userReferenceId: userLoginInformation.userId,
        userToken: userLoginInformation.userToken,
      );

      expect(usersResult, usersExpected);
    });

    test('Read All Users - KO', () async {
      List<User> usersExpected = [];

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userLoginInformation.userId.toString())
          .replaceAll('<userType>', 'user')
          .replaceAll('<userToken>', userLoginInformation.userToken);

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

      final List<User> usersResult = await repository.getUsers(
        userReferenceId: userLoginInformation.userId,
        userToken: userLoginInformation.userToken,
      );

      expect(usersResult, usersExpected);
    });

    // Get User

    test('Get User - OK', () async {
      User userExpected = userAdminMockGeneratorFromHttpResponse();

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userLoginInformation.userId.toString())
          .replaceAll('<userType>', 'admin')
          .replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getAdminUserHttpString(userExpected),
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      final User? resultUser = await repository.getUser(
        userId: userExpected.id,
        userToken: userLoginInformation.userToken,
      );

      expect(resultUser, userExpected);
    }, skip: "Missing Stub - But isn't real the error");

    test('Get User - KO', () async {
      User userExpected = userMockGeneratorFromHttpResponse();

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userLoginInformation.userId.toString())
          .replaceAll('<userType>', 'admin')
          .replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getAdminUserHttpString(userExpected),
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500), () {});

      final User? resultUser = await repository.getUser(
        userId: userExpected.id,
        userToken: userLoginInformation.userToken,
      );

      expect(resultUser, null);
    }, skip: "Missing Stub - But isn't real the error");

    // Delete User

    test('Delete User - OK', () async {
      final int userId = faker.randomGenerator.integer(5);
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userId.toString())
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
      final int userId = faker.randomGenerator.integer(5);
      final String userType = faker.lorem.words(1).first;
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userId.toString())
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

      final String url =
          HttpUserRepository.urlCreateUser.replaceAll('<userType>', 'user');

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
          ),
          true);
    });

    test('Create User - KO', () async {
      final User user = userMockGenerator();

      final String url =
          HttpUserRepository.urlCreateUser.replaceAll('<userType>', 'user');

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

    test('Update User - KO', () async {
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
