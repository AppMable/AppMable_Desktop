import 'dart:developer';

import 'package:appmable_desktop/application/bloc/users/create_user_screen/create_user_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/users/users_screen/users_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../domain/model/objects/mock/user_mock.dart';
import '../../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'create_user_screen_bloc_test.mocks.dart';

@GenerateMocks([
  UsersScreenBloc,
  UserService,
  EncrypterService,
])
void main() {
  final UsersScreenBloc usersScreenBloc = MockUsersScreenBloc();
  final UserService userService = MockUserService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();
  final EncrypterService encrypterService = MockEncrypterService();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  const String passwordEncrypted = 'password_encrypted';
  const String passwordDecrypted = '1234';

  final User user = userMockGenerator(password: passwordDecrypted);
  final Map<String, dynamic> userToCreate = user.toMap();
  userToCreate.remove('id_user_role');

  onCreateSuccess() => log('Success');
  onCreateError(String error) => log(error);

  group('Create User Screen BLoC', () {

    when(encrypterService.encrypt(user.password)).thenAnswer((_) => passwordEncrypted);

    // Create

    blocTest<CreateUserScreenBloc, CreateUserScreenState>(
      'Success Create',
      setUp: () {
        userToCreate['password'] = passwordDecrypted;
        when(userService.createUser(
          user: userToCreate,
        )).thenAnswer((_) => Future.value(true));
      },
      build: () => CreateUserScreenBloc(
        usersScreenBloc,
        userService,
        localStorageService,
        encrypterService,
      ),
      act: (CreateUserScreenBloc bloc) => bloc.add(CreateUserEvent(
        user: userToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [
        const UserCreated(),
      ],
      verify: (_) {
        verifyInOrder([
          userService.createUser(
            user: userToCreate,
          ),
        ]);
      },
    );

    blocTest<CreateUserScreenBloc, CreateUserScreenState>(
      'User Create - false',
      setUp: () {
        userToCreate['password'] = passwordDecrypted;
        when(userService.createUser(
          user: userToCreate,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => CreateUserScreenBloc(
        usersScreenBloc,
        userService,
        localStorageService,
        encrypterService,
      ),
      act: (CreateUserScreenBloc bloc) => bloc.add(CreateUserEvent(
        user: userToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [
        const UserCreated(),
      ],
      verify: (_) {
        verifyInOrder([
          userService.createUser(
            user: userToCreate,
          ),
        ]);
      },
    );

    blocTest<CreateUserScreenBloc, CreateUserScreenState>(
      'User Create - Exception',
      setUp: () {
        userToCreate['password'] = passwordDecrypted;
        when(userService.createUser(
          user: userToCreate,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => CreateUserScreenBloc(
        usersScreenBloc,
        userService,
        localStorageService,
        encrypterService,
      ),
      act: (CreateUserScreenBloc bloc) => bloc.add(CreateUserEvent(
        user: userToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [
        const UserCreated(),
      ],
      verify: (_) {
        verifyInOrder([
          userService.createUser(
            user: userToCreate,
          ),
        ]);
      },
    );
  });
}
