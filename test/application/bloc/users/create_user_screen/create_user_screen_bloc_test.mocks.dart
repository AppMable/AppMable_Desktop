// Mocks generated by Mockito 5.3.2 from annotations
// in appmable_desktop/test/application/bloc/users/create_user_screen/create_user_screen_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:appmable_desktop/application/bloc/users/users_screen/users_screen_bloc.dart'
    as _i2;
import 'package:appmable_desktop/domain/model/objects/user.dart' as _i6;
import 'package:appmable_desktop/domain/services/encrypter_service.dart' as _i7;
import 'package:appmable_desktop/domain/services/user_service.dart' as _i5;
import 'package:flutter_bloc/flutter_bloc.dart' as _i4;
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

class _FakeUsersScreenState_0 extends _i1.SmartFake
    implements _i2.UsersScreenState {
  _FakeUsersScreenState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UsersScreenBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockUsersScreenBloc extends _i1.Mock implements _i2.UsersScreenBloc {
  MockUsersScreenBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UsersScreenState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeUsersScreenState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.UsersScreenState);
  @override
  _i3.Stream<_i2.UsersScreenState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.UsersScreenState>.empty(),
      ) as _i3.Stream<_i2.UsersScreenState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i2.UsersScreenEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i2.UsersScreenEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i2.UsersScreenState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i2.UsersScreenEvent>(
    _i4.EventHandler<E, _i2.UsersScreenState>? handler, {
    _i4.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i4.Transition<_i2.UsersScreenEvent, _i2.UsersScreenState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void onChange(_i4.Change<_i2.UsersScreenState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [UserService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserService extends _i1.Mock implements _i5.UserService {
  MockUserService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i6.User>> getAllUsers({
    required String? userToken,
    required int? userId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllUsers,
          [],
          {
            #userToken: userToken,
            #userId: userId,
          },
        ),
        returnValue: _i3.Future<List<_i6.User>>.value(<_i6.User>[]),
      ) as _i3.Future<List<_i6.User>>);
  @override
  _i3.Future<List<_i6.User>> getUsers({
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
        returnValue: _i3.Future<List<_i6.User>>.value(<_i6.User>[]),
      ) as _i3.Future<List<_i6.User>>);
  @override
  _i3.Future<_i6.User?> getUser({
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
        returnValue: _i3.Future<_i6.User?>.value(),
      ) as _i3.Future<_i6.User?>);
  @override
  _i3.Future<bool> disableUser({
    required Map<String, dynamic>? user,
    required String? userType,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #disableUser,
          [],
          {
            #user: user,
            #userType: userType,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
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

/// A class which mocks [EncrypterService].
///
/// See the documentation for Mockito's code generation for more information.
class MockEncrypterService extends _i1.Mock implements _i7.EncrypterService {
  MockEncrypterService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  String encrypt(String? message) => (super.noSuchMethod(
        Invocation.method(
          #encrypt,
          [message],
        ),
        returnValue: '',
      ) as String);
  @override
  String decrypt(String? message) => (super.noSuchMethod(
        Invocation.method(
          #decrypt,
          [message],
        ),
        returnValue: '',
      ) as String);
}
