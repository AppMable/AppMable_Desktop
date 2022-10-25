import 'dart:async';

abstract class LocalStorageService {
  FutureOr<void> init();

  T read<T>(String key);

  bool hasData(String key);

  Future<void> write(String key, dynamic value);

  void writeInMemory(String key, dynamic value);

  Future<void> remove(String key);
}
