import 'dart:convert';
import 'dart:typed_data';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:appmable_desktop/infrastructure/repositories/user/http_user_repository.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:mockito/mockito.dart';
import '../../../domain/model/objects/mock/user_mock.dart';
import '../../../domain/model/value_objects/mock/user_login_mock.dart';
import 'http_user_repository_test.mocks.dart';

@GenerateMocks([
  HttpService,
  EncrypterService,
])
void main() {
  group('Tests over User Repository', () {
    final Faker faker = Faker();
    final HttpService httpService = MockHttpService();
    final EncrypterService encrypterService = MockEncrypterService();
    final HttpUserRepository repository = HttpUserRepository(
      httpService,
      encrypterService,
    );

    const String passwordEncrypted = 'password_encrypted';
    const String passwordDecrypted = '1234';

    final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();

    // Read All Users

    when(encrypterService.decrypt(passwordEncrypted)).thenAnswer((_) => passwordDecrypted);

    test('Read All Users - OK', () async {
      List<User> usersExpected = List<User>.generate(
          faker.randomGenerator.integer(10),
          (int index) => userMockGeneratorFromHttpResponse(
                id: index,
                idUserReference: userLoginInformation.userId,
                password: passwordDecrypted,
              ));

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userLoginInformation.userId.toString())
          .replaceAll('<userType>', 'user')
          .replaceAll('<userToken>', userLoginInformation.userToken);

      final String bodyResponse = getUsersHttpString(
        users: usersExpected,
        areAdminUsers: false,
        password: passwordEncrypted,
      );

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
      List<User> usersExpected = List<User>.generate(
          faker.randomGenerator.integer(10, min: 1),
          (int index) => userMockGenerator(
                id: index,
                password: passwordDecrypted,
              ));

      User userExpected = userAdminMockGeneratorFromHttpResponse(
        id: usersExpected.last.id + 1,
        password: passwordDecrypted,
      );
      usersExpected.add(userExpected);

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userExpected.id.toString())
          .replaceAll('<userType>', 'admin')
          .replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getUsersHttpString(users: usersExpected, password: passwordEncrypted),
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
    });

    test('Get User - KO', () async {
      User userExpected = userMockGeneratorFromHttpResponse(
        password: passwordDecrypted,
      );

      final String url = HttpUserRepository.urlCrud
          .replaceAll('<userId>', userExpected.id.toString())
          .replaceAll('<userType>', 'admin')
          .replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getAdminUserHttpString(
              userExpected,
              passwordEncrypted,
            ),
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
    });

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
      final User user = userMockGenerator(
        password: passwordDecrypted,
      );

      final String url = HttpUserRepository.urlCreateUser.replaceAll('<userType>', 'user');

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
      final User user = userMockGenerator(
        password: passwordDecrypted,
      );

      final String url = HttpUserRepository.urlCreateUser.replaceAll('<userType>', 'user');

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
      final User user = userMockGenerator(
        password: passwordDecrypted,
      );
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
      final User user = userMockGenerator(
        password: passwordDecrypted,
      );
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
