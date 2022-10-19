import 'dart:developer';

import 'package:appmable_desktop/application/bloc/login_screen/login_screen_bloc.dart';
import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'login_screen_bloc_test.mocks.dart';

@GenerateMocks([
  UserService,
])
void main() {
  final UserService userService = MockUserService();

  final Faker faker = Faker();

  final String username = faker.lorem.words(1).first;
  final String password = faker.lorem.words(1).first;
  onLogInSuccess() => log('success');
  onLogInError(String error) => log(error);

  group('Login Screen BLoC - SuccessLogin', () {

    final LocalStorageService localStorageService = LocalStorageServiceMock();

    blocTest<LoginScreenBloc, LoginScreenState>(
      'Success Login',
      setUp: () {
        when(userService.logIn(username: username, password: password)).thenAnswer((_) => Future.value(true));
      },
      build: () => LoginScreenBloc(
        userService,
        localStorageService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogInEvent(
        username: username,
        password: password,
        onLogInSuccess: onLogInSuccess,
        onLogInError: onLogInError,
      )),
      expect: () => [
        const UserLogged(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLogged) as bool == true,
          'LoginScreen.userLogged value in local storage should be same than ${true}',
        );
        verifyInOrder([
          userService.logIn(username: username, password: password),
        ]);
      },
    );
  });

  group('Login Screen BLoC - LoginException', () {

    final LocalStorageService localStorageService = LocalStorageServiceMock();

    blocTest<LoginScreenBloc, LoginScreenState>(
      'LoginException',
      setUp: () {
        when(userService.logIn(username: username, password: password),).thenThrow((_) => LoginException(faker.lorem.words(5).toString()));
      },
      build: () => LoginScreenBloc(
        userService,
        localStorageService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogInEvent(
        username: username,
        password: password,
        onLogInSuccess: onLogInSuccess,
        onLogInError: onLogInError,
      )),
      expect: () => [],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLogged) == null,
          'LoginScreen.userLogged value in local storage should be same than ${false}',
        );
        verifyInOrder([
          userService.logIn(username: username, password: password),
        ]);
      },
    );
  });

  group('Login Screen BLoC - Random Exception', () {

    final LocalStorageService localStorageService = LocalStorageServiceMock();

    blocTest<LoginScreenBloc, LoginScreenState>(
      'RandomException',
      setUp: () {
        when(userService.logIn(username: username, password: password),).thenThrow((_) => UnimplementedError());
      },
      build: () => LoginScreenBloc(
        userService,
        localStorageService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogInEvent(
        username: username,
        password: password,
        onLogInSuccess: onLogInSuccess,
        onLogInError: onLogInError,
      )),
      expect: () => [],
      verify: (_) {
        assert(
        localStorageService.read(LoginScreen.userLogged) == null,
        'LoginScreen.userLogged value in local storage should be same than ${false}',
        );
        verifyInOrder([
          userService.logIn(username: username, password: password),
        ]);
      },
    );
  });
}
