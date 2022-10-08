import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

// TODO: Can be freezed
class Response extends Equatable {
  final int statusCode;
  final String body;
  final Map<String, String> headers;

  const Response({
    required this.statusCode,
    required this.body,
    required this.headers,
  });

  Map<String, dynamic> toMap() => {
        'statusCode': statusCode,
        'body': body,
        'headers': headers,
      };

  factory Response.fromMap(Map<String, dynamic> map) {
    if (map['statusCode'] is! int ||
        map['body'] is! String ||
        map['headers'] is! Map<String, String>) {
      throw MalformedResponseMapException(map);
    }

    return Response(
      statusCode: map['statusCode'],
      body: map['body'],
      headers: map['headers'],
    );
  }

  @override
  List<Object?> get props => [
        statusCode,
        body,
        headers,
      ];
}

class MalformedResponseMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedResponseMapException(this.map);
}
