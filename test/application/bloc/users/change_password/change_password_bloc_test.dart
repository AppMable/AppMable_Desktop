import 'dart:developer';

import 'package:appmable_desktop/application/bloc/users/change_password/change_password_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../domain/model/objects/mock/user_mock.dart';
import '../../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'change_password_bloc_test.mocks.dart';

@GenerateMocks([
  UserService,
])
void main() {
  final UserService userService = MockUserService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final User user = userMockGenerator();
  localStorageService.write(DashboardScreen.userInformation, user.toJson());

  final Map<String, dynamic> userToUpdate = user.toMap();
  userToUpdate.remove('health_card_identifier');
  userToUpdate.remove('id_user_reference');

  DateTime dateOfBirth = DateFormat("yyyy-MM-dd").parse(userToUpdate['date_of_birth']);
  userToUpdate['date_of_birth'] = DateFormat('yyyy-MM-dd').format(dateOfBirth);

  onUpdateSuccess() => log('Success');

  group('Change Password Events', () {
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'True',
      setUp: () {
        when(userService.updateUser(
          user: userToUpdate,
          userType: 'admin',
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));

      },
      build: () => ChangePasswordBloc(
        userService,
        localStorageService,
      ),
      act: (ChangePasswordBloc bloc) => bloc.add(ChangePassword(
        password: userToUpdate['password'],
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const PasswordUpdating(),
        const PasswordUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          userService.updateUser(
            user: userToUpdate,
            userType: 'admin',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'False',
      setUp: () {
        when(userService.updateUser(
          user: userToUpdate,
          userType: 'admin',
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => ChangePasswordBloc(
        userService,
        localStorageService,
      ),
      act: (ChangePasswordBloc bloc) => bloc.add(ChangePassword(
        password: userToUpdate['password'],
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const PasswordUpdating(),
        const PasswordNotUpdated(error: 'No se ha podido actualizar la contraseña'),
      ],
      verify: (_) {
        verifyInOrder([
          userService.updateUser(
            user: userToUpdate,
            userType: 'admin',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Exception',
      setUp: () {
        when(userService.updateUser(
          user: userToUpdate,
          userType: 'admin',
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => ChangePasswordBloc(
        userService,
        localStorageService,
      ),
      act: (ChangePasswordBloc bloc) => bloc.add(ChangePassword(
        password: userToUpdate['password'],
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const PasswordUpdating(),
        const PasswordNotUpdated(error: 'No se ha podido actualizar la contraseña'),
      ],
      verify: (_) {
        verifyInOrder([
          userService.updateUser(
            user: userToUpdate,
            userType: 'admin',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });

  group('Reset Change Password BLoC State', () {
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Reset',
      build: () => ChangePasswordBloc(
        userService,
        localStorageService,
      ),
      act: (ChangePasswordBloc bloc) => bloc.add(const ClosePopupChangePassword()),
      expect: () => [
        const ChangePasswordInitial(),
      ],
    );
  });
}
