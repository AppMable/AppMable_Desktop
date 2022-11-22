import 'dart:developer';

import 'package:appmable_desktop/application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/contacts/update_contact_screen/update_contact_screen_bloc.dart';
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
import 'update_contact_screen_bloc_test.mocks.dart';

@GenerateMocks([
  ContactsScreenBloc,
  ContactService,
])
void main() {
  final ContactsScreenBloc contactScreenBloc = MockContactsScreenBloc();
  final ContactService contactService = MockContactService();
  final LocalStorageService localStorageService = LocalStorageServiceMock();

  final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();
  localStorageService.write(LoginScreen.userLoginInformation, userLoginInformation.toJson());

  final Contact contact = contactMockGenerator();
  final Map<String, dynamic> contactToUpdate = contact.toMap();

  onUpdateSuccess() => log('Success');
  onUpdateError(String error) => log(error);

  group('Update Contact Screen BLoC', () {

    // UpdateContactEvent

    blocTest<UpdateContactScreenBloc, UpdateContactScreenState>(
      'Success Update',
      setUp: () {
        when(contactService.updateContact(
          contact: contactToUpdate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(true));
      },
      build: () => UpdateContactScreenBloc(
        contactScreenBloc,
        contactService,
        localStorageService,
      ),
      act: (UpdateContactScreenBloc bloc) => bloc.add(UpdateContactEvent(
        userId: userLoginInformation.userId,
        contact: contactToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const ContactUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.updateContact(
            contact: contactToUpdate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UpdateContactScreenBloc, UpdateContactScreenState>(
      'User Update - False',
      setUp: () {
        when(contactService.updateContact(
          contact: contactToUpdate,
          userToken: userLoginInformation.userToken,
        )).thenAnswer((_) => Future.value(false));
      },
      build: () => UpdateContactScreenBloc(
        contactScreenBloc,
        contactService,
        localStorageService,
      ),
      act: (UpdateContactScreenBloc bloc) => bloc.add(UpdateContactEvent(
        userId: userLoginInformation.userId,
        contact: contactToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const ContactUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.updateContact(
            contact: contactToUpdate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );

    blocTest<UpdateContactScreenBloc, UpdateContactScreenState>(
      'User Update - Exception',
      setUp: () {
        when(contactService.updateContact(
          contact: contactToUpdate,
          userToken: userLoginInformation.userToken,
        )).thenThrow((_) => UnimplementedError());
      },
      build: () => UpdateContactScreenBloc(
        contactScreenBloc,
        contactService,
        localStorageService,
      ),
      act: (UpdateContactScreenBloc bloc) => bloc.add(UpdateContactEvent(
        userId: userLoginInformation.userId,
        contact: contactToUpdate,
        onError: onUpdateError,
        onSuccess: onUpdateSuccess,
      )),
      expect: () => [
        const ContactUpdated(),
      ],
      verify: (_) {
        verifyInOrder([
          contactService.updateContact(
            contact: contactToUpdate,
            userToken: userLoginInformation.userToken,
          ),
        ]);
      },
    );
  });
}
