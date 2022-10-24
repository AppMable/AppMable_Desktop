import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';
import 'package:flutter/material.dart';

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
        idUserRole,
        idUserReference,
      ];

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'identity_number': identityNumber,
        'health_card_identifier': healthCardIdentifier,
        'username': username,
        'password': password,
        'name': name,
        'surname': surname,
        'email': email,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth.toString(),
        'date_created': dateCreated.toString(),
        'date_last_login': dateLastLogin.toString(),
        'id_user_role': idUserRole,
        'id_user_reference': idUserReference,
      };

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
      dateOfBirth: map['date_of_birth'] != null ? DateUtils.dateOnly(DateTime.parse(map['date_of_birth'])) : null,
      dateCreated: map['date_created'] != null ? DateTime.parse(map['date_created']) : null,
      dateLastLogin: map['date_last_login'] != null ? DateTime.parse(map['date_last_login']) : null,
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
