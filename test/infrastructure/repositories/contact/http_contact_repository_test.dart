import 'dart:convert';
import 'dart:typed_data';

import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/infrastructure/repositories/contact/http_contact_repository.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:mockito/mockito.dart';
import '../../../domain/model/objects/mock/contact_mock.dart';
import '../../../domain/model/value_objects/mock/user_login_mock.dart';
import 'http_contact_repository_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group('Tests over Contact Repository', () {
    final Faker faker = Faker();
    final HttpService httpService = MockHttpService();
    final HttpContactRepository repository = HttpContactRepository(httpService);

    final UserLoginInformation userLoginInformation = userLoginInformationMockGenerator();

    // Read All Contacts

    test('Read All Contacts - OK', () async {
      List<Contact> contactsExpected = List<Contact>.generate(
          faker.randomGenerator.integer(10),
          (int index) => contactMockGenerator(
                id: index,
                idUser: [userLoginInformation.userId],
              ));

      final String url =
          HttpContactRepository.urlGetAllContacts.replaceAll('<userToken>', userLoginInformation.userToken);

      final String bodyResponse = getContactsHttpString(contacts: contactsExpected);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: bodyResponse,
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(utf8.encode(bodyResponse)),
          ),
        ),
      );

      final List<Contact> contactResult = await repository.getContacts(
        userId: userLoginInformation.userId,
        userToken: userLoginInformation.userToken,
      );

      expect(contactResult, contactsExpected);
    });

    test('Read All Contacts - KO', () async {
      List<User> contactsExpected = [];

      final String url =
          HttpContactRepository.urlGetAllContacts.replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      final List<Contact> contactResult = await repository.getContacts(
        userId: userLoginInformation.userId,
        userToken: userLoginInformation.userToken,
      );

      expect(contactResult, contactsExpected);
    });

    // Get Contact

    test('Get Contact - OK', () async {

      List<Contact> contactsExpected = List<Contact>.generate(
          faker.randomGenerator.integer(10, min: 1),
              (int index) => contactMockGenerator(
            id: index,
            idUser: [userLoginInformation.userId],
          ));

      Contact contactExpected = contactMockGenerator(id: contactsExpected.last.id + 1);
      contactsExpected.add(contactExpected);

      final String url =
          HttpContactRepository.urlGetAllContacts.replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getContactsHttpString(contacts: contactsExpected),
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      final Contact? resultContact = await repository.getContact(
        contactId: contactExpected.id,
        userToken: userLoginInformation.userToken,
      );

      expect(resultContact, contactExpected);
    });

    test('Get Contact - KO', () async {

      List<Contact> contactsExpected = List<Contact>.generate(
          faker.randomGenerator.integer(10, min: 1),
              (int index) => contactMockGenerator(
            id: index,
            idUser: [userLoginInformation.userId],
          ));

      Contact contactExpected = contactMockGenerator(id: contactsExpected.last.id + 1);
      contactsExpected.add(contactExpected);

      final String url =
          HttpContactRepository.urlGetAllContacts.replaceAll('<userToken>', userLoginInformation.userToken);

      when(httpService.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(
          Response(
            body: getContactsHttpString(contacts: contactsExpected),
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500), () {});

      final Contact? resultContact = await repository.getContact(
        contactId: contactExpected.id,
        userToken: userLoginInformation.userToken,
      );

      expect(resultContact, null);
    });

    // Delete Contact

    test('Delete User - OK', () async {
      final int contactId = faker.randomGenerator.integer(5);
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpContactRepository.urlCrud
          .replaceAll('<contactId>', contactId.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.delete(Uri.parse(urlDelete))).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.deleteContact(
            contactId: contactId,
            userToken: userToken,
          ),
          true);
    });

    test('Delete User - KO', () async {
      final int contactId = faker.randomGenerator.integer(5);
      final String userToken = faker.lorem.words(1).first;

      final String urlDelete = HttpContactRepository.urlCrud
          .replaceAll('<contactId>', contactId.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.delete(Uri.parse(urlDelete))).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.deleteContact(
            contactId: contactId,
            userToken: userToken,
          ),
          false);
    });

    // Create Contact

    test('Create Contact - OK', () async {
      final Contact contact = contactMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpContactRepository.urlGetAllContacts.replaceAll('<userToken>', userToken);

      when(httpService.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 201,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.createContact(
            contact: contact.toMap(),
            userToken: userToken,
          ),
          true);
    });

    test('Create Contact - KO', () async {
      final Contact contact = contactMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpContactRepository.urlGetAllContacts.replaceAll('<userToken>', userToken);

      when(httpService.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.createContact(
            contact: contact.toMap(),
            userToken: userToken,
          ),
          false);
    });

    // Update Contact

    test('Update Contact - OK', () async {
      final Contact contact = contactMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpContactRepository.urlCrud
          .replaceAll('<contactId>', contact.id.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 200,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.updateContact(
            contact: contact.toMap(),
            userToken: userToken,
          ),
          true);
    });

    test('Update Contact - KO', () async {
      final Contact contact = contactMockGenerator();
      final String userToken = faker.lorem.words(1).first;

      final String url = HttpContactRepository.urlCrud
          .replaceAll('<contactId>', contact.id.toString())
          .replaceAll('<userToken>', userToken);

      when(httpService.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact.toMap()),
      )).thenAnswer(
        (_) => Future.value(
          Response(
            body: '',
            statusCode: 403,
            headers: const {'header': 'mock'},
            bodyBytes: Uint8List.fromList(faker.randomGenerator.numbers(5, 5)),
          ),
        ),
      );

      expect(
          await repository.updateContact(
            contact: contact.toMap(),
            userToken: userToken,
          ),
          false);
    });
  });
}
