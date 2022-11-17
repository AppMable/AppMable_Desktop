import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

class Alert extends Equatable {
  final int id;

  const Alert({
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
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
    );
  }
}

class MalformedButtonMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedButtonMapException(this.map);
}
