import 'package:appmable_desktop/domain/model/objects/user.dart';

abstract class UserRepository {
  Future<List<User>> readAllUsers({
    required int currentUserId,
    required String userToken,
    required String userType,
  });

  Future<User?> getUser({
    required String userId,
    required String userType,
    required String userToken,
  });

  Future<bool> deleteUser({
    required String userId,
    required String userType,
    required String userToken,
  });
}
