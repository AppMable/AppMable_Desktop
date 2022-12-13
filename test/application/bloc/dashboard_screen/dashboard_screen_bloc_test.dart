import 'package:appmable_desktop/application/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/user_info/user_info_bloc.dart';
import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
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
  UserInfoBloc,
])
void main() {
  final UserService userService = MockUserService();
  final UserInfoBloc userInfoBloc = MockUserInfoBloc();

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
      wait: Duration(milliseconds: Config.defaultDelay * 2),
      build: () => DashboardScreenBloc(
        localStorageService,
        userService,
        userInfoBloc,
      ),
      expect: () => [
        const DashboardScreenLoading(),
        const DashboardScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(UserInfo.userInformation) is String,
          'UserInfo.userInformation value in local storage should be a String',
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
      wait: Duration(milliseconds: Config.defaultDelay * 2),
      build: () => DashboardScreenBloc(
        localStorageService,
        userService,
        userInfoBloc,
      ),
      expect: () => [
        const DashboardScreenLoading(),
        const DashboardScreenLoaded(),
      ],
      verify: (_) {
        assert(
          localStorageService.read(UserInfo.userInformation) == null,
          'UserInfo.userInformation value in local storage should be null',
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
