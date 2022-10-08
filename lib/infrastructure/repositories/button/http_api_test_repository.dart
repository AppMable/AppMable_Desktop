import 'dart:convert';

import 'package:appmable_desktop/domain/repositories/api_test_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: ApiTestRepository)
class HttpApiTestRepository implements ApiTestRepository {
  final HttpService _httpService;

  HttpApiTestRepository(
    this._httpService,
  );

  static const String url = 'http://127.0.0.1:8000/api/';

  @override
  Future<String> readMessage() async {
    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['missatge'];
    } else {
      throw Error();
    }
  }
}
