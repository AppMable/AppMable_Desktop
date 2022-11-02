import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

class User extends Equatable {
  final int id;
  final String identityNumber;
  final String? healthCardIdentifier;
  final String username;
  final String password;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final DateTime? dateOfBirth;
  final DateTime? dateCreated;
  final DateTime? dateLastLogin;
  final DateTime? dateLastLogout;
  final int? idUserRole;
  final int? idUserReference;

  const User({
    required this.id,
    required this.identityNumber,
    required this.username,
    required this.password,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    this.dateOfBirth,
    this.dateCreated,
    this.dateLastLogin,
    this.dateLastLogout,
    this.healthCardIdentifier,
    this.idUserRole,
    this.idUserReference,
  });

  @override
  List<Object?> get props => [
        id,
        identityNumber,
        healthCardIdentifier,
        username,
        password,
        name,
        surname,
        email,
        phoneNumber,
        dateOfBirth,
        dateCreated,
        dateLastLogin,
        dateLastLogout,
        idUserRole,
        idUserReference,
      ];

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'identity_number': identityNumber,
      'health_card_identifier': healthCardIdentifier,
      'username': username,
      'password': password,
      'name': name,
      'surname': surname,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth != null ? dateOfBirth.toString() : dateOfBirth,
      'date_created': dateCreated != null ? dateCreated.toString() : dateCreated,
      'date_last_login': dateLastLogin != null ? dateLastLogin.toString() : dateLastLogin,
      'date_last_logout': dateLastLogout != null ? dateLastLogout.toString() : dateLastLogout,
      'id_user_role': idUserRole,
      'id_user_reference': idUserReference,
    };

    if(dateOfBirth == null) map.remove('date_of_birth');
    if(dateCreated == null) map.remove('date_created');
    if(dateLastLogin == null) map.remove('date_last_login');
    if(dateLastLogout == null) map.remove('date_last_logout');

    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map['id'] is! int ||
        map['identity_number'] is! String ||
        map['username'] is! String ||
        map['password'] is! String ||
        map['name'] is! String ||
        map['surname'] is! String ||
        map['email'] is! String ||
        (map['health_card_identifier'] is! String?) ||
        (map['id_user_role'] is! int?) ||
        (map['id_user_reference'] is! int?) ||
        (map['date_of_birth'] is! String) ||
        (map['date_created'] is! String) ||
        (map['date_last_login'] is! String?) ||
        (map['date_last_logout'] is! String?) ||
        (map['phone_number'] is! String)) throw MalformedButtonMapException(map);

    return User(
      id: map['id'],
      identityNumber: map['identity_number'],
      healthCardIdentifier: map['health_card_identifier'],
      username: map['username'],
      password: map['password'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      phoneNumber: map['phone_number'],
      dateOfBirth: map['date_of_birth'] != null && map['date_of_birth'] != 'null' ? DateTime.parse(map['date_of_birth']) : null,
      dateCreated: map['date_created'] != null && map['date_created'] != 'null' ? DateTime.parse(map['date_created']) : null,
      dateLastLogin: map['date_last_login'] != null && map['date_last_login'] != 'null' ? DateTime.parse(map['date_last_login']) : null,
      dateLastLogout: map['date_last_logout'] != null && map['date_last_logout'] != 'null' ? DateTime.parse(map['date_last_logout']) : null,
      idUserRole: map['id_user_role'],
      idUserReference: map['id_user_reference'],
    );
  }
}

class MalformedButtonMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedButtonMapException(this.map);
}
