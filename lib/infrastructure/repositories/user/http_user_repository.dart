import 'dart:convert';

import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: UserRepository)
class HttpUserRepository implements UserRepository {
  final HttpService _httpService;

  HttpUserRepository(
    this._httpService,
  );

  static const String urlUserLogin = 'http://127.0.0.1:8000/users/login/<username>/<password>/';

  @override
  Future<bool> logIn({
    required String username,
    required String password,
  }) async {
    final String urlLogin = urlUserLogin.replaceAll('<username>', username).replaceAll('<password>', password);

    final Response response = await _httpService.get(Uri.parse(urlLogin));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw LoginException(jsonDecode(utf8.decode(response.bodyBytes))[0]);
    }
    return false;
  }
}
