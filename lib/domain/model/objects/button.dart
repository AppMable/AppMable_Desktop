import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

class Button extends Equatable {
  final int id;
  final String action;

  const Button({
    required this.id,
    required this.action,
  });

  @override
  List<Object?> get props => [
        id,
        action,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'action': action,
      };

  factory Button.fromMap(Map<String, dynamic> map) {
    if (map['id'] is! int ||
        map['action'] is! String) throw MalformedButtonMapException(map);

    return Button(
      id: map['id'],
      action: map['action'],
    );
  }
}

class MalformedButtonMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedButtonMapException(this.map);
}
