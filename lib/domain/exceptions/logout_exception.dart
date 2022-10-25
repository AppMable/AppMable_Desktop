class LogOutException implements Exception {
  final String message;

  const LogOutException(
    this.message,
  );

  @override
  String toString() => message;
}
