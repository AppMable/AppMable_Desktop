import 'dart:developer';

import 'package:appmable_desktop/application/bloc/users/users_screen/users_screen_bloc.dart';
import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../domain/model/objects/mock/user_mock.dart';
import '../../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'users_screen_bloc_test.mocks.dart';

@GenerateMocks([
  UserService,
])
void main() {
  final UserService userService = MockUserService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final Faker faker = Faker();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  List<User> users =
      List<User>.generate(faker.randomGenerator.integer(10), (int index) => userMockGenerator(idUserReference: 1));

  onDeleteSuccess() => log('Success');
  onDeleteError(String error) => log(error);

  group('Users Screen BLoC', () {
    // UsersScreenEventLoad
    blocTest<UsersScreenBloc, UsersScreenState>(
      'Success Load',
      setUp: () {
        when(userService.getUsers(
          userReferenceId: userLoginInformation.userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(users));
      },
      wait: Duration(milliseconds: Config.defaultDelay),
      build: () => UsersScreenBloc(
        userService,
        localStorageService,
      ),
      expect: () => [
        const UsersScreenLoading(),
        UsersScreenLoaded(users: users),
      ],
      verify: (_) {
        verifyInOrder([
          userService.getUsers(
            userReferenceId: userLoginInformation.userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    // UsersScreenDeleteEvent

    final int userIdToDelete = faker.randomGenerator.integer(5);

    blocTest<UsersScreenBloc, UsersScreenState>(
      'Success Delete',
      setUp: () {
        when(userService.getUsers(
          userReferenceId: userLoginInformation.userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(users));

        when(userService.deleteUser(
          userId: userIdToDelete,
          userType: 'user',
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      build: () => UsersScreenBloc(
        userService,
        localStorageService,
      ),
      wait: Duration(milliseconds: Config.defaultDelay),
      act: (UsersScreenBloc bloc) => bloc.add(UsersScreenDeleteEvent(
        userId: userIdToDelete,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const UsersScreenLoading(),
        UsersScreenLoaded(users: users),
      ],
      verify: (_) {
        verifyInOrder([
          userService.deleteUser(
            userId: userIdToDelete,
            userType: 'user',
            userToken: userLoginInformation.userToken,
          ),
          userService.getUsers(
            userReferenceId: userLoginInformation.userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UsersScreenBloc, UsersScreenState>(
      'Delete - False',
      setUp: () {
        when(userService.getUsers(
          userReferenceId: userLoginInformation.userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(users));

        when(userService.deleteUser(
          userId: userIdToDelete,
          userType: 'user',
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => UsersScreenBloc(
        userService,
        localStorageService,
      ),
      wait: Duration(milliseconds: Config.defaultDelay),
      act: (UsersScreenBloc bloc) => bloc.add(UsersScreenDeleteEvent(
        userId: userIdToDelete,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const UsersScreenLoading(),
        UsersScreenLoaded(users: users),
      ],
      verify: (_) {
        verifyInOrder([
          userService.getUsers(
            userReferenceId: userLoginInformation.userId,
            userToken: userLoginInformation.userToken,
          ),
          userService.deleteUser(
            userId: userIdToDelete,
            userType: 'user',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UsersScreenBloc, UsersScreenState>(
      'Delete - Exception',
      setUp: () {
        when(userService.getUsers(
          userReferenceId: userLoginInformation.userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(users));

        when(userService.deleteUser(
          userId: userIdToDelete,
          userType: 'user',
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => UsersScreenBloc(
        userService,
        localStorageService,
      ),
      wait: Duration(milliseconds: Config.defaultDelay),
      act: (UsersScreenBloc bloc) => bloc.add(UsersScreenDeleteEvent(
        userId: userIdToDelete,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const UsersScreenLoading(),
        UsersScreenLoaded(users: users),
      ],
      verify: (_) {
        verifyInOrder([
          userService.getUsers(
            userReferenceId: userLoginInformation.userId,
            userToken: userLoginInformation.userToken,
          ),
          userService.deleteUser(
            userId: userIdToDelete,
            userType: 'user',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
