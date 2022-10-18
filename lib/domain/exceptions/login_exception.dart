class LoginException implements Exception {
  final String message;

  const LoginException(
    this.message,
  );

  @override
  String toString() => message;
}
