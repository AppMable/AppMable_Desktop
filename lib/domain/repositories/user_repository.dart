import 'package:appmable_desktop/domain/model/objects/user.dart';

abstract class UserRepository {
  Future<List<User>> readAllUsers({
    required String userToken,
  });

  Future<User?> getUser({
    required String userId,
    required String userType,
    required String userToken,
  });
}
