import 'dart:developer';

import 'package:appmable_desktop/application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart';
import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/contact_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../domain/model/objects/mock/contact_mock.dart';
import '../../../../domain/model/value_objects/mock/user_login_mock.dart';
import '../../../../domain/services/storage/mock/local_storage_service_mock.dart';
import 'contacts_screen_bloc_test.mocks.dart';

@GenerateMocks([
  ContactService,
])
void main() {
  final ContactService contactService = MockContactService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final Faker faker = Faker();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final int userId = faker.randomGenerator.integer(20);

  List<Contact> contacts =
      List<Contact>.generate(faker.randomGenerator.integer(10), (int index) => contactMockGenerator(idUser: [userId]));

  onDeleteSuccess() => log('Success');
  onDeleteError(String error) => log(error);

  group('Contacts Screen BLoC', () {
    // ContactScreenEventLoad
    blocTest<ContactsScreenBloc, ContactsScreenState>(
      'Success Load',
      setUp: () {
        when(contactService.getContacts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(contacts));
      },
      build: () => ContactsScreenBloc(
        contactService,
        localStorageService,
      ),
      expect: () => [],
      verify: (_) {
        verifyInOrder([]);
      },
    );

    blocTest<ContactsScreenBloc, ContactsScreenState>(
      'Success Load - Sending Event',
      setUp: () {
        when(contactService.getContacts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(contacts));
      },
      wait: Duration(milliseconds: Config.defaultDelay),
      build: () => ContactsScreenBloc(
        contactService,
        localStorageService,
      ),
      act: (ContactsScreenBloc bloc) => bloc.add(ContactsScreenEventLoad(
        userId: userId,
      )),
      expect: () => [
        const ContactsScreenLoading(),
        ContactsScreenLoaded(contacts: contacts),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.getContacts(
            userId: userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    // ContactsScreenLoadedDeleteEvent

    final int contactIdToDelete = faker.randomGenerator.integer(5);

    blocTest<ContactsScreenBloc, ContactsScreenState>(
      'Success Delete',
      setUp: () {
        when(contactService.getContacts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(contacts));

        when(contactService.deleteContact(
          contactId: contactIdToDelete,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      wait: Duration(milliseconds: Config.defaultDelay),
      build: () => ContactsScreenBloc(
        contactService,
        localStorageService,
      ),
      act: (ContactsScreenBloc bloc) => bloc.add(ContactsScreenDeleteEvent(
        contactId: contactIdToDelete,
        userId: userId,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const ContactsScreenLoading(),
        ContactsScreenLoaded(contacts: contacts),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.deleteContact(
            contactId: contactIdToDelete,
            userToken: userLoginInformation.userToken,
          ),
          contactService.getContacts(
            userId: userId,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<ContactsScreenBloc, ContactsScreenState>(
      'Delete - False',
      setUp: () {
        when(contactService.getContacts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(contacts));

        when(contactService.deleteContact(
          contactId: contactIdToDelete,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => ContactsScreenBloc(
        contactService,
        localStorageService,
      ),
      act: (ContactsScreenBloc bloc) => bloc.add(ContactsScreenDeleteEvent(
        contactId: contactIdToDelete,
        userId: userId,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const ContactsScreenLoading(),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.deleteContact(
            contactId: contactIdToDelete,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<ContactsScreenBloc, ContactsScreenState>(
      'Delete - Exception',
      setUp: () {
        when(contactService.getContacts(
          userId: userId,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(contacts));

        when(contactService.deleteContact(
          contactId: contactIdToDelete,
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => ContactsScreenBloc(
        contactService,
        localStorageService,
      ),
      act: (ContactsScreenBloc bloc) => bloc.add(ContactsScreenDeleteEvent(
        userId: userId,
        contactId: contactIdToDelete,
        onSuccess: onDeleteSuccess,
        onError: onDeleteError,
      )),
      expect: () => [
        const ContactsScreenLoading(),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.deleteContact(
            contactId: contactIdToDelete,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
