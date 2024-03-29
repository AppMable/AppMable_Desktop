// Mocks generated by Mockito 5.3.2 from annotations
// in appmable_desktop/test/application/bloc/contacts/update_contact_screen/update_contact_screen_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:appmable_desktop/application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart'
    as _i2;
import 'package:appmable_desktop/domain/model/objects/contact.dart' as _i6;
import 'package:appmable_desktop/domain/services/contact_service.dart' as _i5;
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

class _FakeContactsScreenState_0 extends _i1.SmartFake
    implements _i2.ContactsScreenState {
  _FakeContactsScreenState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ContactsScreenBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactsScreenBloc extends _i1.Mock
    implements _i2.ContactsScreenBloc {
  MockContactsScreenBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ContactsScreenState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeContactsScreenState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.ContactsScreenState);
  @override
  _i3.Stream<_i2.ContactsScreenState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.ContactsScreenState>.empty(),
      ) as _i3.Stream<_i2.ContactsScreenState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i2.ContactsScreenEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i2.ContactsScreenEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i2.ContactsScreenState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i2.ContactsScreenEvent>(
    _i4.EventHandler<E, _i2.ContactsScreenState>? handler, {
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
          _i4.Transition<_i2.ContactsScreenEvent, _i2.ContactsScreenState>?
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
  void onChange(_i4.Change<_i2.ContactsScreenState>? change) =>
      super.noSuchMethod(
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

/// A class which mocks [ContactService].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactService extends _i1.Mock implements _i5.ContactService {
  MockContactService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i6.Contact>> getContacts({
    required int? userId,
    required String? userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getContacts,
          [],
          {
            #userId: userId,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<List<_i6.Contact>>.value(<_i6.Contact>[]),
      ) as _i3.Future<List<_i6.Contact>>);
  @override
  _i3.Future<_i6.Contact?> getContact({
    required int? contactId,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getContact,
          [],
          {
            #contactId: contactId,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<_i6.Contact?>.value(),
      ) as _i3.Future<_i6.Contact?>);
  @override
  _i3.Future<bool> deleteContact({
    required int? contactId,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteContact,
          [],
          {
            #contactId: contactId,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> createContact({
    required Map<String, dynamic>? contact,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createContact,
          [],
          {
            #contact: contact,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> updateContact({
    required Map<String, dynamic>? contact,
    required dynamic userToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateContact,
          [],
          {
            #contact: contact,
            #userToken: userToken,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
