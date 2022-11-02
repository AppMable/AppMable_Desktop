import 'dart:convert';

import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/domain/exceptions/logout_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/repositories/user_login_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: UserLoginRepository)
class HttpUserLoginRepository implements UserLoginRepository {
  final HttpService _httpService;

  HttpUserLoginRepository(
    this._httpService,
  );

  static const String urlUserLogin = 'http://127.0.0.1:8000/users/login/?u=<username>&p=<password>';
  static const String urlUserLogOut = 'http://127.0.0.1:8000/users/logout/?c=<userToken>';

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
        userId: int.parse(userLoginInformation[0]),
        userName: userLoginInformation[1],
        userRole: userLoginInformation[2],
        userToken: userLoginInformation[3],
      );
    } else if (response.statusCode == 403) {
      throw LoginException(jsonDecode(utf8.decode(response.bodyBytes))[0]);
    }
    return null;
  }

  @override
  Future<bool> logOut({
    required String userToken,
  }) async {
    final String urlLogOut = urlUserLogOut.replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(urlLogOut));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw const LogOutException('No tienes permisos para hacer LogOut');
    }
    return false;
  }
}
