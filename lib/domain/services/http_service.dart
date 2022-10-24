import 'package:appmable_desktop/domain/model/value_object/response.dart';

abstract class HttpService {
  Future<Response> get(Uri url, {Map<String, String>? headers});
  Future<Response> post(Uri url, {Map<String, String>? headers});
  Future<Response> put(Uri url, {Map<String, String>? headers});
  Future<Response> delete(Uri url, {Map<String, String>? headers});
}