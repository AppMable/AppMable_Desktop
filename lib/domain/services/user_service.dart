import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final UserRepository _userRepository;

  const UserService(
    this._userRepository,
  );

  Future<List<User>> readAllUsers({
    required userToken,
  }) async {
    return _userRepository.readAllUsers(userToken: userToken);
  }
}
