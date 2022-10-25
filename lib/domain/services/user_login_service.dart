import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/repositories/user_login_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserLoginService {
  final UserLoginRepository _userLoginRepository;

  const UserLoginService(
    this._userLoginRepository,
  );

  Future<UserLoginInformation?> logIn({
    required String username,
    required String password,
  }) async {
    try {
      return await _userLoginRepository.logIn(
        username: username,
        password: password,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> logOut({
    required String userToken,
  }) async {
    try {
      return await _userLoginRepository.logOut(
        userToken: userToken,
      );
    } catch (_) {
      rethrow;
    }
  }
}
