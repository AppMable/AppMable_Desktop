import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

class Alert extends Equatable {
  final int id;
  final String name;
  final String surname;
  final String phoneNumber;
  final String email;
  final String address;
  final int? idUser;

  const Alert({
    required this.id,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.idUser,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        phoneNumber,
        email,
        address,
        idUser,
      ];

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
    };

    return map;
  }

    factory Alert.fromMap(Map<String, dynamic> map) {
    if (map['id'] is! int) throw MalformedButtonMapException(map);

    return Alert(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      address: map['address'],
      idUser: map['idUser'],
    );
  }
}

class MalformedButtonMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedButtonMapException(this.map);
}
