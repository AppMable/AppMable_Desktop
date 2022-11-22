// Mocks generated by Mockito 5.3.2 from annotations
// in appmable_desktop/test/application/bloc/dashboard_screen/dashboard_screen_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:appmable_desktop/domain/model/objects/user.dart' as _i4;
import 'package:appmable_desktop/domain/services/user_service.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [UserService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserService extends _i1.Mock implements _i2.UserService {
  MockUserService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.User>> getUsers({
    required int? userReferenceId,
    required String? userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUsers,
          [],
          {
            #userReferenceId: userReferenceId,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<List<_i4.User>>.value(<_i4.User>[]),
      ) as _i3.Future<List<_i4.User>>);
  @override
  _i3.Future<_i4.User?> getUser({
    required int? userId,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
          {
            #userId: userId,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<_i4.User?>.value(),
      ) as _i3.Future<_i4.User?>);
  @override
  _i3.Future<bool> deleteUser({
    required int? userId,
    required String? userType,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [],
          {
            #userId: userId,
            #userType: userType,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> createAdminUser({required Map<String, dynamic>? user}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAdminUser,
          [],
          {#user: user},
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> createUser({required Map<String, dynamic>? user}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUser,
          [],
          {#user: user},
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> updateUser({
    required Map<String, dynamic>? user,
    required String? userType,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [],
          {
            #user: user,
            #userType: userType,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
