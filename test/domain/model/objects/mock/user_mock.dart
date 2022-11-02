import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:faker/faker.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:flutter/material.dart';

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
    dateOfBirth: dateOfBirth ??  DateUtils.dateOnly(faker.date.dateTime()),
    dateCreated: dateCreated ?? faker.date.dateTime(),
    dateLastLogin: dateLastLogin ?? faker.date.dateTime(),
    dateLastLogout: dateLastLogout ?? faker.date.dateTime(),
    healthCardIdentifier: healthCardIdentifier ?? faker.lorem.words(1).first,
    idUserRole: idUserRole ?? faker.randomGenerator.integer(9),
    idUserReference: idUserReference ?? faker.randomGenerator.integer(9),
  );
}

String getUsersLoginHttpString(UserLoginInformation userLoginInformation){
  return '["login:${userLoginInformation.userRole}:${userLoginInformation.userName}:${userLoginInformation.userToken}"]';
}
