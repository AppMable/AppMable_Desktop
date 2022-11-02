import 'package:appmable_desktop/domain/model/objects/user.dart';

abstract class UserRepository {
  Future<List<User>> readAllUsers({
    required int currentUserId,
    required String userToken,
    required String userType,
  });

  Future<User?> getUser({
    required int userId,
    required String userType,
    required String userToken,
  });

  Future<bool> deleteUser({
    required int userId,
    required String userType,
    required String userToken,
  });

  Future<bool> createUser({
    required Map<String, dynamic> user,
    required String userType,
    required String userToken,
  });

  Future<bool> updateUser({
    required Map<String, dynamic> user,
    required String userType,
    required String userToken,
  });
}
