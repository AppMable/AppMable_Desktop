import 'dart:developer';

import 'package:appmable_desktop/application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/contacts/create_contact_screen/create_contact_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/contact_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../domain/model/objects/mock/contact_mock.dart';
import '../../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'create_contact_screen_bloc_test.mocks.dart';

@GenerateMocks([
  ContactsScreenBloc,
  ContactService,
])
void main() {
  final ContactsScreenBloc contactsScreenBloc = MockContactsScreenBloc();
  final ContactService contactService = MockContactService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final Contact contact = contactMockGenerator();
  final Map<String, dynamic> contactToCreate = contact.toMap();

  onCreateSuccess() => log('Success');
  onCreateError(String error) => log(error);

  group('Create Contact Screen BLoC', () {
    // Create

    blocTest<CreateContactScreenBloc, CreateContactScreenState>(
      'Success Create',
      setUp: () {
        when(contactService.createContact(
          contact: contactToCreate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      build: () => CreateContactScreenBloc(
        contactsScreenBloc,
        contactService,
        localStorageService,
      ),
      act: (CreateContactScreenBloc bloc) => bloc.add(CreateContactEvent(
        userId: userLoginInformation.userId,
        contact: contactToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [
        const ContactCreated(),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.createContact(
            contact: contactToCreate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<CreateContactScreenBloc, CreateContactScreenState>(
      'User Create - false',
      setUp: () {
        when(contactService.createContact(
          contact: contactToCreate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => CreateContactScreenBloc(
        contactsScreenBloc,
        contactService,
        localStorageService,
      ),
      act: (CreateContactScreenBloc bloc) => bloc.add(CreateContactEvent(
        userId: userLoginInformation.userId,
        contact: contactToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [],
      verify: (_) {
        verifyInOrder([
          contactService.createContact(
            contact: contactToCreate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<CreateContactScreenBloc, CreateContactScreenState>(
      'User Create - Exception',
      setUp: () {
        when(contactService.createContact(
          contact: contactToCreate,
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => CreateContactScreenBloc(
        contactsScreenBloc,
        contactService,
        localStorageService,
      ),
      act: (CreateContactScreenBloc bloc) => bloc.add(CreateContactEvent(
        userId: userLoginInformation.userId,
        contact: contactToCreate,
        onError: onCreateError,
        onSuccess: onCreateSuccess,
      )),
      expect: () => [],
      verify: (_) {
        verifyInOrder([
          contactService.createContact(
            contact: contactToCreate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
