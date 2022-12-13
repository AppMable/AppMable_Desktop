import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

// TODO: Can be freezed
class UserLoginInformation extends Equatable {

  static const adminRole = 'Administrador';
  static const tutorRole = 'Tutor';
  static const wardedRole = 'Tutelado';

  final int userId;
  final String userRole;
  final String userName;
  final String userToken;

  const UserLoginInformation({
    required this.userId,
    required this.userRole,
    required this.userName,
    required this.userToken,
  });

  bool get isSuperAdmin => userRole == adminRole;
  bool get isTutor => userRole == tutorRole;
  bool get isWarded => userRole == wardedRole;

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userRole': userRole,
        'userName': userName,
        'userToken': userToken,
      };

  factory UserLoginInformation.fromMap(Map<String, dynamic> map) {
    if (map['userId'] is! int ||
        map['userRole'] is! String ||
        map['userName'] is! String ||
        map['userToken'] is! String) {
      throw MalformedResponseMapException(map);
    }

    return UserLoginInformation(
      userId: map['userId'],
      userRole: map['userRole'],
      userName: map['userName'],
      userToken: map['userToken'],
    );
  }

  @override
  List<Object?> get props => [
        userId,
        userRole,
        userName,
        userToken,
      ];

  String toJson() {
    return jsonEncode(toMap());
  }
}

class MalformedResponseMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedResponseMapException(this.map);
}
