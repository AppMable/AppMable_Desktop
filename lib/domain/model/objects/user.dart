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
  final DateTime dateOfBirth;
  final DateTime dateCreated;
  final DateTime dateLastLogin;
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
    required this.dateOfBirth,
    required this.dateCreated,
    required this.dateLastLogin,
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

  Map<String, dynamic> toMap() => {
        'id': id,
        'identityNumber': identityNumber,
        'healthCardIdentifier': healthCardIdentifier,
        'username': username,
        'password': password,
        'name': name,
        'surname': surname,
        'email': email,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'dateCreated': dateCreated,
        'dateLastLogin': dateLastLogin,
        'idUserRole': idUserRole,
        'idUserReference': idUserReference,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    if (map['id'] is! int ||
        map['identity_number'] is! String ||
        map['username'] is! String ||
        map['password'] is! String ||
        map['name'] is! String ||
        map['surname'] is! String ||
        map['email'] is! String ||
        map['phone_number'] is! String) throw MalformedButtonMapException(map);

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
      dateOfBirth: DateTime.now(),
      dateCreated: DateTime.now(),
      dateLastLogin: DateTime.now(),
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
