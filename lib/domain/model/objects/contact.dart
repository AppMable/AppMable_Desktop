import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

class Contact extends Equatable {
  final int id;
  final String name;
  final String surname;
  final String phoneNumber;
  final String address;
  final String email;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final List? idUser;

  const Contact({
    required this.id,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.address,
    required this.email,
    this.dateCreated,
    this.dateUpdated,
    this.idUser,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        phoneNumber,
        address,
        email,
        dateCreated,
        dateUpdated,
        idUser,
      ];

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'surname': surname,
      'phone_number': surname,
      'address': address,
      'email': email,
      'date_created': dateCreated != null ? dateCreated.toString() : dateCreated,
      'date_updated': dateUpdated != null ? dateUpdated.toString() : dateUpdated,
      'id_user': idUser,
    };

    return map;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    if (map['id'] is! int ||
        map['name'] is! String ||
        map['surname'] is! String ||
        map['phone_number'] is! String ||
        map['address'] is! String ||
        map['email'] is! String ||
        (map['date_created'] is! String?) ||
        (map['date_updated'] is! String?) ||
        (map['id_user'] is! List?)) throw MalformedButtonMapException(map);

    return Contact(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      phoneNumber: map['phone_number'],
      address: map['address'],
      email: map['email'],
      dateCreated:
          map['date_created'] != null && map['date_created'] != 'null' ? DateTime.parse(map['date_created']) : null,
      dateUpdated:
          map['date_updated'] != null && map['date_updated'] != 'null' ? DateTime.parse(map['date_updated']) : null,
      idUser: map['id_user'],
    );
  }
}

class MalformedButtonMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedButtonMapException(this.map);
}
