import 'package:appmable_desktop/application/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../domain/model/objects/mock/user_mock.dart';
import '../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'dashboard_screen_bloc_test.mocks.dart';

@GenerateMocks([
  UserService,
])
void main() {
  final UserService userService = MockUserService();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();

  group('Dashboard Screen BLoC - User Loaded', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();

    localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

    blocTest<DashboardScreenBloc, DashboardScreenState>(
      'Success Get information',
      setUp: () {
        when(userService.getUser(
          userId: userLoginInformation.userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(userMockGenerator(id: 1)));
      },
      wait: Duration(milliseconds: Config.defaultDelay),
      build: () => DashboardScreenBloc(
        localStorageService,
        userService,
      ),
      expect: () => [
        const DashboardScreenLoading(),
        const DashboardScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(DashboardScreen.userInformation) is String,
          'DashboardScreen.userInformation value in local storage should be a String',
        );
        verifyInOrder([
          userService.getUser(
            userId: userLoginInformation.userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });

  group('Dashboard Screen BLoC - User NOT Loaded', () {
    final LocalStorageService localStorageService = LocalStorageServiceMock();

    localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

    blocTest<DashboardScreenBloc, DashboardScreenState>(
      'No user',
      setUp: () {
        when(userService.getUser(
          userId: userLoginInformation.userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(null));
      },
      wait: Duration(milliseconds: Config.defaultDelay),
      build: () => DashboardScreenBloc(
        localStorageService,
        userService,
      ),
      expect: () => [
        const DashboardScreenLoading(),
        const DashboardScreenLoaded(),
      ],
      verify: (_) {
        assert(
        localStorageService.read(DashboardScreen.userInformation) == null,
        'DashboardScreen.userInformation value in local storage should be null',
        );
        verifyInOrder([
          userService.getUser(
            userId: userLoginInformation.userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
