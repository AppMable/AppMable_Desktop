import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';

abstract class UserLoginRepository {
  Future<UserLoginInformation?> logIn({
    required String username,
    required String password,
  });

  Future<bool> logOut({
    required String userToken,
  });
}
