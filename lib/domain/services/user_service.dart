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
    required currentUserId,
    required userToken,
    required String userType,
  }) async {
    return _userRepository.readAllUsers(
      currentUserId: currentUserId,
      userToken: userToken,
      userType: userType,
    );
  }

  Future<User?> getUser({
    required String userId,
    required String userType,
    required userToken,
  }) async {
    return _userRepository.getUser(
      userId: userId,
      userType: userType,
      userToken: userToken,
    );
  }

  Future<bool> deleteUser({
    required String userId,
    required String userType,
    required userToken,
  }) async {
    return _userRepository.deleteUser(
      userId: userId,
      userType: userType,
      userToken: userToken,
    );
  }
}
