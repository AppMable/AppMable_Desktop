import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';

abstract class UserRepository {
  Future<UserLoginInformation?> logIn({
    required String username,
    required String password,
  });
}
