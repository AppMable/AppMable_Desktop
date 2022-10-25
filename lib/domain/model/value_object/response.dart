import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:appmable_desktop/domain/exceptions/malformed_map_exception.dart';

// TODO: Can be freezed
class Response extends Equatable {
  final int statusCode;
  final String body;
  final Uint8List bodyBytes;
  final Map<String, String> headers;

  const Response({
    required this.statusCode,
    required this.body,
    required this.bodyBytes,
    required this.headers,
  });

  Map<String, dynamic> toMap() => {
        'statusCode': statusCode,
        'body': body,
        'bodyBytes': bodyBytes,
        'headers': headers,
      };

  factory Response.fromMap(Map<String, dynamic> map) {
    if (map['statusCode'] is! int ||
        map['body'] is! String ||
        map['bodyBytes'] is! Uint8List ||
        map['headers'] is! Map<String, String>) {
      throw MalformedResponseMapException(map);
    }

    return Response(
      statusCode: map['statusCode'],
      body: map['body'],
      bodyBytes: map['bodyBytes'],
      headers: map['headers'],
    );
  }

  @override
  List<Object?> get props => [
        statusCode,
        body,
        bodyBytes,
        headers,
      ];
}

class MalformedResponseMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedResponseMapException(this.map);
}
