import 'dart:convert';

import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: UserRepository)
class HttpButtonRepository implements UserRepository {
  final HttpService _httpService;

  HttpButtonRepository(
    this._httpService,
  );

  static const String urlUserLogin = 'http://127.0.0.1:8000/users/login/<username>/<password>/';

  @override
  Future<UserLoginInformation?> logIn({
    required String username,
    required String password,
  }) async {
    final String urlLogin = urlUserLogin.replaceAll('<username>', username).replaceAll('<password>', password);

    final Response response = await _httpService.get(Uri.parse(urlLogin));

    if (response.statusCode == 200) {
      List<String> userLoginInformation = jsonDecode(response.body)[0].split(':');
      return UserLoginInformation(
        loginType: userLoginInformation[1],
        userRole: userLoginInformation[2],
        userName: userLoginInformation[3],
        userToken: userLoginInformation[4],
      );
    } else if (response.statusCode == 403) {
      throw LoginException(jsonDecode(utf8.decode(response.bodyBytes))[0]);
    }
    return null;
  }
}
