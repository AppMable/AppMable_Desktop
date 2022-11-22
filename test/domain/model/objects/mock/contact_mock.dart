import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:faker/faker.dart';

Contact contactMockGenerator({
  int? id,
  String? name,
  String? surname,
  String? phoneNumber,
  String? address,
  String? email,
  DateTime? dateCreated,
  DateTime? dateUpdated,
  List? idUser,
}) {
  return Contact(
    id: id ?? faker.randomGenerator.integer(9),
    name: name ?? faker.address.person.firstName(),
    surname: surname ?? faker.address.person.lastName(),
    email: email ?? faker.internet.email(),
    phoneNumber: phoneNumber ?? faker.phoneNumber.toString(),
    address: phoneNumber ?? faker.address.streetAddress(),
    dateCreated: dateCreated ?? faker.date.dateTime(),
    dateUpdated: dateUpdated ?? faker.date.dateTime(),
    idUser: idUser ??
        List<int>.generate(faker.randomGenerator.integer(10), (int index) => faker.randomGenerator.integer(10)),
  );
}

String getContactHttpString(Contact contact) {
  return '''
  {
    "id": ${contact.id},
    "name": "${contact.name}",
    "surname": "${contact.surname}",
    "email": "${contact.email}",
    "phone_number": "${contact.phoneNumber}",
    "address": "${contact.address}",
    "date_created": "${contact.dateCreated?.toString()}",
    "date_updated": "${contact.dateUpdated?.toString()}",
    "id_user": ${contact.idUser}
  }
 ''';
}

String getContactsHttpString({
  required List<Contact> contacts,
}) {
  String list = '[';

  final int numOfContacts = contacts.length;
  int i = 0;

  for (Contact contact in contacts) {
    i++;
    list += getContactHttpString(contact);
    if (i != numOfContacts) list += ',';
  }
  list += ']';
  return list;
}
