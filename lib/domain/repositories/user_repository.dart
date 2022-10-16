abstract class UserRepository {
  Future<bool> logIn({
    required String username,
    required String password,
  });
}
