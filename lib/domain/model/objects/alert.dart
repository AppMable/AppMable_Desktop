import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

class Alert extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int soundLevel;
  final int vibrationLevel;
  final int timeLength;
  final DateTime? dateEnabled;
  final DateTime? dateDisabled;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final int idUser;

  const Alert({
    required this.id,
    required this.name,
    required this.soundLevel,
    required this.vibrationLevel,
    required this.timeLength,
    required this.idUser,
    this.description,
    this.dateEnabled,
    this.dateDisabled,
    this.dateCreated,
    this.dateUpdated,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        soundLevel,
        vibrationLevel,
        timeLength,
        idUser,
        dateEnabled,
        dateDisabled,
        dateCreated,
        dateUpdated,
      ];

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'description': description,
      'sound_level': soundLevel,
      'vibration_level': vibrationLevel,
      'time_length': timeLength,
      'id_user': idUser,
      'date_enabled': dateEnabled != null ? dateEnabled.toString() : dateEnabled,
      'date_disabled': dateDisabled != null ? dateDisabled.toString() : dateDisabled,
      'date_created': dateCreated != null ? dateCreated.toString() : dateCreated,
      'date_updated': dateUpdated != null ? dateUpdated.toString() : dateUpdated,
    };

    return map;
  }

  factory Alert.fromMap(Map<String, dynamic> map) {
    if (map['id'] is! int ||
        map['name'] is! String ||
        (map['description'] is! String?) ||
        map['sound_level'] is! int ||
        map['vibration_level'] is! int ||
        map['time_length'] is! int ||
        map['id_user'] is! int ||
        (map['date_enabled'] is! String?) ||
        (map['date_disabled'] is! String?) ||
        (map['date_created'] is! String?) ||
        (map['date_updated'] is! String?)) throw MalformedButtonMapException(map);

    return Alert(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      soundLevel: map['sound_level'],
      vibrationLevel: map['vibration_level'],
      timeLength: map['time_length'],
      idUser: map['id_user'],
      dateEnabled:
          map['date_enabled'] != null && map['date_enabled'] != 'null' ? DateTime.parse(map['date_enabled']) : null,
      dateDisabled:
          map['date_disabled'] != null && map['date_disabled'] != 'null' ? DateTime.parse(map['date_disabled']) : null,
      dateCreated:
          map['date_created'] != null && map['date_created'] != 'null' ? DateTime.parse(map['date_created']) : null,
      dateUpdated:
          map['date_updated'] != null && map['date_updated'] != 'null' ? DateTime.parse(map['date_updated']) : null,
    );
  }
}

class MalformedButtonMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedButtonMapException(this.map);
}
