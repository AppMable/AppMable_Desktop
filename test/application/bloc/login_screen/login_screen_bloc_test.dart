import 'dart:developer';

import 'package:appmable_desktop/application/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/dashboard_screen_super_admin/dashboard_screen_super_admin_bloc.dart';
import 'package:appmable_desktop/application/bloc/login_screen/login_screen_bloc.dart';
import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/domain/exceptions/logout_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:appmable_desktop/domain/services/start_up_router_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_login_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'login_screen_bloc_test.mocks.dart';

@GenerateMocks([
  UserLoginService,
  StartUpRouterService,
  DashboardScreenBloc,
  DashboardScreenSuperAdminBloc,
  EncrypterService,
])
void main() {
  final UserLoginService userLoginService = MockUserLoginService();
  final StartUpRouterService startUpRouterService = MockStartUpRouterService();
  final DashboardScreenBloc dashboardScreenBloc = MockDashboardScreenBloc();
  final DashboardScreenSuperAdminBloc dashboardScreenSuperAdminBloc = MockDashboardScreenSuperAdminBloc();
  final EncrypterService encrypterService = MockEncrypterService();

  final Faker faker = Faker();

  final String username = faker.lorem.words(1).first;
  final String password = faker.lorem.words(1).first;
  final String passwordEncrypted = faker.lorem.words(1).first;
  ;
  onLogInSuccess(String routeName) => log('success');
  onLogInError(String error) => log(error);

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  final String userToken = userLoginInformation.userToken;
  onLogOutSuccess() => log('success');
  onLogOutError(String error) => log(error);

  // LogInEvent

  group('Login Screen BLoC - SuccessLogin', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();

    blocTest<LoginScreenBloc, LoginScreenState>(
      'Success Login',
      setUp: () {
        when(userLoginService.logIn(
          username: username,
          password: passwordEncrypted,
        )).thenAnswer((_) => Future.value(userLoginInformation));

        when(encrypterService.encrypt(password)).thenAnswer((_) => passwordEncrypted);

        when(startUpRouterService.execute()).thenAnswer((_) => Future.value(faker.lorem.words(1).first));

      },
      build: () => LoginScreenBloc(
        userLoginService,
        localStorageService,
        startUpRouterService,
        dashboardScreenBloc,
        dashboardScreenSuperAdminBloc,
        encrypterService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogInEvent(
        username: username,
        password: password,
        onLogInSuccess: onLogInSuccess,
        onLogInError: onLogInError,
      )),
      expect: () => [
        const LoginScreenLoaded(),
        const UserLogged(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLoginInformation) is String,
          'LoginScreen.userLogged value in local storage should be a String',
        );
        verifyInOrder([
          userLoginService.logIn(username: username, password: passwordEncrypted),
        ]);
      },
    );
  });

  group('Login Screen BLoC - LoginException', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();

    blocTest<LoginScreenBloc, LoginScreenState>(
      'LoginException',
      setUp: () {
        when(
          userLoginService.logIn(
            username: username,
            password: passwordEncrypted,
          ),
        ).thenThrow((_) => LoginException(faker.lorem.words(5).toString()));

        when(encrypterService.encrypt(password)).thenAnswer((_) => passwordEncrypted);
      },
      build: () => LoginScreenBloc(
        userLoginService,
        localStorageService,
        startUpRouterService,
        dashboardScreenBloc,
        dashboardScreenSuperAdminBloc,
        encrypterService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogInEvent(
        username: username,
        password: password,
        onLogInSuccess: onLogInSuccess,
        onLogInError: onLogInError,
      )),
      expect: () => [
        const LoginScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLoginInformation) == null,
          'LoginScreen.userLogged value in local storage should be same than ${null}',
        );
        verifyInOrder([
          userLoginService.logIn(username: username, password: passwordEncrypted),
        ]);
      },
    );
  });

  group('Login Screen BLoC - Random in LogInEvent Exception', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();

    blocTest<LoginScreenBloc, LoginScreenState>(
      'RandomException',
      setUp: () {
        when(
          userLoginService.logIn(username: username, password: passwordEncrypted),
        ).thenThrow((_) => UnimplementedError());
        when(encrypterService.encrypt(password)).thenAnswer((_) => passwordEncrypted);
      },
      build: () => LoginScreenBloc(
        userLoginService,
        localStorageService,
        startUpRouterService,
        dashboardScreenBloc,
        dashboardScreenSuperAdminBloc,
        encrypterService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogInEvent(
        username: username,
        password: password,
        onLogInSuccess: onLogInSuccess,
        onLogInError: onLogInError,
      )),
      expect: () => [
        const LoginScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLoginInformation) == null,
          'LoginScreen.userLogged value in local storage should be same than ${null}',
        );
        verifyInOrder([
          userLoginService.logIn(username: username, password: passwordEncrypted),
        ]);
      },
    );
  });

  // LogOutEvent

  group('Login Screen BLoC - SuccessLogout', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();
    localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

    blocTest<LoginScreenBloc, LoginScreenState>(
      'Success Login',
      setUp: () {
        when(userLoginService.logOut(userToken: userToken)).thenAnswer((_) => Future.value(true));
      },
      build: () => LoginScreenBloc(
        userLoginService,
        localStorageService,
        startUpRouterService,
        dashboardScreenBloc,
        dashboardScreenSuperAdminBloc,
        encrypterService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogOutEvent(
        onLogOutSuccess: onLogOutSuccess,
        onLogOutError: onLogOutError,
      )),
      expect: () => [
        const LoginScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLoginInformation) == null,
          'LoginScreen.userLogged value in local storage should be null',
        );
        verifyInOrder([
          userLoginService.logOut(userToken: userToken),
        ]);
      },
    );
  });

  group('Login Screen BLoC - LogoutException', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();
    localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

    blocTest<LoginScreenBloc, LoginScreenState>(
      'LogOutException',
      setUp: () {
        when(
          userLoginService.logOut(userToken: userToken),
        ).thenThrow((_) => LogOutException(faker.lorem.words(5).toString()));
      },
      build: () => LoginScreenBloc(
        userLoginService,
        localStorageService,
        startUpRouterService,
        dashboardScreenBloc,
        dashboardScreenSuperAdminBloc,
        encrypterService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogOutEvent(
        onLogOutSuccess: onLogOutSuccess,
        onLogOutError: onLogOutError,
      )),
      expect: () => [
        const LoginScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLoginInformation) is String,
          'LoginScreen.userLogged value in local storage should be a String',
        );
        verifyInOrder([
          userLoginService.logOut(userToken: userToken),
        ]);
      },
    );
  });

  group('Login Screen BLoC - Random in LogOutEvent Exception', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();
    localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

    blocTest<LoginScreenBloc, LoginScreenState>(
      'RandomException',
      setUp: () {
        when(
          userLoginService.logOut(userToken: userToken),
        ).thenThrow((_) => UnimplementedError());
      },
      build: () => LoginScreenBloc(
        userLoginService,
        localStorageService,
        startUpRouterService,
        dashboardScreenBloc,
        dashboardScreenSuperAdminBloc,
        encrypterService,
      ),
      act: (LoginScreenBloc bloc) => bloc.add(LogOutEvent(
        onLogOutSuccess: onLogOutSuccess,
        onLogOutError: onLogOutError,
      )),
      expect: () => [
        const LoginScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(LoginScreen.userLoginInformation) is String,
          'LoginScreen.userLogged value in local storage should be a String',
        );
        verifyInOrder([
          userLoginService.logOut(userToken: userToken),
        ]);
      },
    );
  });
}
