import 'dart:convert';

import 'package:appmable_desktop/domain/exceptions/login_exception.dart';
import 'package:appmable_desktop/domain/exceptions/logout_exception.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/repositories/user_login_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:fast_rsa/fast_rsa.dart';

@Injectable(as: UserLoginRepository)
class HttpUserLoginRepository implements UserLoginRepository {
  final HttpService _httpService;

  HttpUserLoginRepository(
    this._httpService,
  );

  static const String urlUserLogin = '${const String.fromEnvironment("server")}users/login/?u=<username>&p=<password>';
  static const String urlUserLogOut = '${const String.fromEnvironment("server")}users/logout/?c=<userToken>';

  @override
  Future<UserLoginInformation?> logIn({
    required String username,
    required String password,
  }) async {

    // var passwordEncrypted = await RSA.encryptPKCS1v15(password, 'publicKey'); TODO: pending

    var passwordEncrypted = password;

    final String urlLogin = urlUserLogin.replaceAll('<username>', username).replaceAll('<password>', passwordEncrypted);

    final Response response = await _httpService.get(Uri.parse(urlLogin));

    if (response.statusCode == 200) {
      List<String> userLoginInformation = jsonDecode(response.body)[0].split(':');

      if(userLoginInformation.length == 3){
        return UserLoginInformation(
          userId: int.parse(userLoginInformation[0]),
          userName: userLoginInformation[1],
          userRole: UserLoginInformation.wardedRole,
          userToken: userLoginInformation[2],
        );
      }

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
