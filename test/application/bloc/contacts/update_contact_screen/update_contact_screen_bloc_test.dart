import 'dart:developer';

import 'package:appmable_desktop/application/bloc/users/update_user_screen/update_user_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/users/users_screen/users_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
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
import 'update_contact_screen_bloc_test.mocks.dart';

@GenerateMocks([
  UsersScreenBloc,
  UserService,
])
void main() {
  final UsersScreenBloc usersScreenBloc = MockUsersScreenBloc();
  final UserService userService = MockUserService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final User user = userMockGenerator();
  final Map<String, dynamic> userToUpdate = user.toMap();
  userToUpdate.remove('id_user_role');

  onUpdateSuccess() => log('Success');
  onUpdateError(String error) => log(error);

  group('Update User Screen BLoC', () {

    // UpdateUserEvent

    blocTest<UpdateUserScreenBloc, UpdateUserScreenState>(
      'Success Update',
      setUp: () {
        when(userService.updateUser(
          user: userToUpdate,
          userType: 'user',
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      build: () => UpdateUserScreenBloc(
        usersScreenBloc,
        userService,
        localStorageService,
      ),
      act: (UpdateUserScreenBloc bloc) => bloc.add(UpdateUserEvent(
        userId: user.id.toString(),
        user: userToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const UserUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          userService.updateUser(
            user: userToUpdate,
            userType: 'user',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UpdateUserScreenBloc, UpdateUserScreenState>(
      'User Update - False',
      setUp: () {
        when(userService.updateUser(
          user: userToUpdate,
          userType: 'user',
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => UpdateUserScreenBloc(
        usersScreenBloc,
        userService,
        localStorageService,
      ),
      act: (UpdateUserScreenBloc bloc) => bloc.add(UpdateUserEvent(
        userId: user.id.toString(),
        user: userToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const UserUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          userService.updateUser(
            user: userToUpdate,
            userType: 'user',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UpdateUserScreenBloc, UpdateUserScreenState>(
      'User Update - Exception',
      setUp: () {
        when(userService.updateUser(
          user: userToUpdate,
          userType: 'user',
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => UpdateUserScreenBloc(
        usersScreenBloc,
        userService,
        localStorageService,
      ),
      act: (UpdateUserScreenBloc bloc) => bloc.add(UpdateUserEvent(
        userId: user.id.toString(),
        user: userToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const UserUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          userService.updateUser(
            user: userToUpdate,
            userType: 'user',
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
