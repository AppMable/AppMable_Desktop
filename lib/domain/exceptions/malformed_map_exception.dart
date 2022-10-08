class MalformedMapException implements Exception {
  final Map<String, dynamic> map;

  const MalformedMapException(this.map);
}
