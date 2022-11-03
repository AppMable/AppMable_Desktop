import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:faker/faker.dart';

User userMockGenerator({
  int? id,
  String? identityNumber,
  String? healthCardIdentifier,
  String? username,
  String? password,
  String? name,
  String? surname,
  String? email,
  String? phoneNumber,
  DateTime? dateOfBirth,
  DateTime? dateCreated,
  DateTime? dateLastLogin,
  DateTime? dateLastLogout,
  int? idUserRole,
  int? idUserReference,
}) {
  return User(
    id: id ?? faker.randomGenerator.integer(9),
    identityNumber: identityNumber ?? faker.lorem.words(1).first,
    username: username ?? faker.lorem.words(1).first,
    password: password ?? faker.lorem.words(1).first,
    name: name ?? faker.address.person.firstName(),
    surname: surname ?? faker.address.person.lastName(),
    email: email ?? faker.internet.email(),
    phoneNumber: phoneNumber ?? faker.phoneNumber.toString(),
    dateOfBirth: dateOfBirth ?? faker.date.dateTime(),
    dateCreated: dateCreated ?? faker.date.dateTime(),
    dateLastLogin: dateLastLogin ?? faker.date.dateTime(),
    dateLastLogout: dateLastLogout ?? faker.date.dateTime(),
    healthCardIdentifier: healthCardIdentifier ?? faker.lorem.words(1).first,
    idUserRole: idUserRole ?? faker.randomGenerator.integer(9),
    idUserReference: idUserReference ?? faker.randomGenerator.integer(9),
  );
}

User userAdminMockGeneratorFromHttpResponse({
  int? id,
  String? identityNumber,
  String? username,
  String? password,
  String? name,
  String? surname,
  String? email,
  String? phoneNumber,
  DateTime? dateOfBirth,
  DateTime? dateCreated,
  DateTime? dateLastLogin,
  int? idUserRole,
}) {
  return User(
    id: id ?? faker.randomGenerator.integer(9),
    identityNumber: identityNumber ?? faker.lorem.words(1).first,
    username: username ?? faker.lorem.words(1).first,
    password: password ?? faker.lorem.words(1).first,
    name: name ?? faker.address.person.firstName(),
    surname: surname ?? faker.address.person.lastName(),
    email: email ?? faker.internet.email(),
    phoneNumber: phoneNumber ?? faker.phoneNumber.toString(),
    dateOfBirth: dateOfBirth ?? faker.date.dateTime(),
    dateCreated: dateCreated ?? faker.date.dateTime(),
    dateLastLogin: dateLastLogin ?? faker.date.dateTime(),
    idUserRole: idUserRole ?? faker.randomGenerator.integer(9),
  );
}

User userMockGeneratorFromHttpResponse({
  int? id,
  String? identityNumber,
  String? healthCardIdentifier,
  String? username,
  String? password,
  String? name,
  String? surname,
  String? email,
  String? phoneNumber,
  DateTime? dateOfBirth,
  DateTime? dateCreated,
  DateTime? dateLastLogin,
  DateTime? dateLastLogout,
  int? idUserReference,
}) {
  return User(
    id: id ?? faker.randomGenerator.integer(9),
    identityNumber: identityNumber ?? faker.lorem.words(1).first,
    healthCardIdentifier: healthCardIdentifier ?? faker.lorem.words(1).first,
    username: username ?? faker.lorem.words(1).first,
    password: password ?? faker.lorem.words(1).first,
    name: name ?? faker.address.person.firstName(),
    surname: surname ?? faker.address.person.lastName(),
    email: email ?? faker.internet.email(),
    phoneNumber: phoneNumber ?? faker.phoneNumber.toString(),
    dateOfBirth: dateOfBirth ?? faker.date.dateTime(),
    dateCreated: dateCreated ?? faker.date.dateTime(),
    dateLastLogin: dateLastLogin ?? faker.date.dateTime(),
    dateLastLogout: dateLastLogout ?? faker.date.dateTime(),
    idUserReference: idUserReference ?? faker.randomGenerator.integer(9),
  );
}

String getAdminUserHttpString(User user) {
  return '''
  {
    "id": ${user.id},
    "identity_number": "${user.identityNumber}",
    "username": "${user.username}",
    "password": "${user.password}",
    "name": "${user.name}",
    "surname": "${user.surname}",
    "email": "${user.email}",
    "phone_number": "${user.phoneNumber}",
    "date_of_birth": "${user.dateOfBirth.toString()}",
    "date_created": "${user.dateCreated?.toString()}",
    "date_last_login": "${user.dateLastLogin?.toString()}",
    "id_user_role": ${user.idUserRole}
  }
''';
}

String getUserHttpString(User user) {
  return '''
  {
    "id": ${user.id},
    "identity_number": "${user.identityNumber}",
    "username": "${user.username}",
    "password": "${user.password}",
    "name": "${user.name}",
    "surname": "${user.surname}",
    "email": "${user.email}",
    "phone_number": "${user.phoneNumber}",
    "date_of_birth": "${user.dateOfBirth?.toString()}",
    "date_created": "${user.dateCreated?.toString()}",
    "date_last_login": "${user.dateLastLogin?.toString()}",
    "id_user_reference": ${user.idUserReference},
    "health_card_identifier": "${user.healthCardIdentifier}",
    "date_last_logout": "${user.dateLastLogout?.toString()}"
  }
 ''';
}

String getUsersHttpString({ required List<User> users, bool areAdminUsers = true}) {
  String list = '[';

  final int numOfUsers = users.length;
  int i = 0;

  for (User user in users) {
    i++;
    list += areAdminUsers ? getAdminUserHttpString(user) : getUserHttpString(user);
    if (i != numOfUsers) list += ',';
  }
  list += ']';
  return list;
}
