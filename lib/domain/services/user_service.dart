import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final UserRepository _userRepository;

  const UserService(
    this._userRepository,
  );

  Future<List<User>> getUsers({
    required int userReferenceId,
    required String userToken,
  }) async {
    return _userRepository.getUsers(
      userReferenceId: userReferenceId,
      userToken: userToken,
    );
  }

  Future<User?> getUser({
    required int userId,
    required userToken,
  }) async {
    return _userRepository.getUser(
      userId: userId,
      userToken: userToken,
    );
  }

  Future<bool> deleteUser({
    required int userId,
    required String userType,
    required userToken,
  }) async {
    return _userRepository.deleteUser(
      userId: userId,
      userType: userType,
      userToken: userToken,
    );
  }

  Future<bool> createAdminUser({
    required Map<String, dynamic> user,
  }) async {
    return _userRepository.createAdminUser(
      user: user,
    );
  }

  Future<bool> createUser({
    required Map<String, dynamic> user,
  }) async {
    return _userRepository.createUser(
      user: user,
    );
  }

  Future<bool> updateUser({
    required Map<String, dynamic> user,
    required String userType,
    required userToken,
  }) async {
    return _userRepository.updateUser(
      user: user,
      userType: userType,
      userToken: userToken,
    );
  }
}
