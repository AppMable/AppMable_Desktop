import 'dart:async';

import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';

class LocalStorageServiceMock extends LocalStorageService {
  final Map<String, dynamic> _storage = <String, dynamic>{};
  bool storageActive = false;

  @override
  Future<void> init() async {
    storageActive = true;
  }

  void guardClause() {
    if (!storageActive) {
      throw DeferredLoadException('GetStorage not initialized');
    }
  }

  @override
  T read<T>(String key) {
    return _storage[key] as T;
  }

  @override
  bool hasData(String key) {
    return _storage[key] != null;
  }

  @override
  Future<void> write(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  void writeInMemory(String key, dynamic value) {
    _storage[key] = value;
  }
}
