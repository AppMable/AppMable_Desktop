import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final UserRepository _userRepository;

  const UserService(
    this._userRepository,
  );

  Future<UserLoginInformation?> logIn({
    required String username,
    required String password,
  }) async {
    try {
      return await _userRepository.logIn(
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
      return await _userRepository.logOut(
        userToken: userToken,
      );
    } catch (_) {
      rethrow;
    }
  }
}
