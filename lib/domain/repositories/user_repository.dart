import 'package:appmable_desktop/domain/model/objects/user.dart';

abstract class UserRepository {
  Future<List<User>> readAllUsers({
    required String userToken,
  });
}
