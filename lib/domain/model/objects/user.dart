import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

class User extends Equatable {
  final int id;
  final String identityNumber;
  final String username;
  final String password;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final DateTime dateLastLogin;

  const User({
    required this.id,
    required this.identityNumber,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.dateCreated,
    required this.dateUpdated,
    required this.dateLastLogin,
  });

  @override
  List<Object?> get props => [
        id,
        identityNumber,
        username,
        password,
        name,
        email,
        phoneNumber,
        dateOfBirth,
        dateCreated,
        dateUpdated,
        dateLastLogin,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'identityNumber': identityNumber,
        'username': username,
        'password': password,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'dateCreated': dateCreated,
        'dateUpdated': dateUpdated,
        'dateLastLogin': dateLastLogin,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    if (map['id'] is! int ||
        map['identityNumber'] is! String ||
        map['username'] is! String ||
        map['password'] is! String ||
        map['name'] is! String ||
        map['email'] is! String ||
        map['phoneNumber'] is! String ||
        map['dateOfBirth'] is! DateTime ||
        map['dateCreated'] is! DateTime ||
        map['dateUpdated'] is! DateTime ||
        map['dateLastLogin'] is! DateTime) throw MalformedButtonMapException(map);

    return User(
      id: map['id'],
      identityNumber: map['identityNumber'],
      username: map['username'],
      password: map['password'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      dateOfBirth: map['dateOfBirth'],
      dateCreated: map['dateCreated'],
      dateUpdated: map['dateUpdated'],
      dateLastLogin: map['dateLastLogin'],
    );
  }
}

class MalformedButtonMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedButtonMapException(this.map);
}
