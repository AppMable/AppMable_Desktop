import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageLocalStorageService implements LocalStorageService {
  static GetStorageLocalStorageService? _instance;
  final GetStorage _storage;
  bool storageActive = false;

  GetStorageLocalStorageService() : _storage = GetStorage();

  GetStorageLocalStorageService._internal() : _storage = GetStorage();

  static GetStorageLocalStorageService _init() => _instance = GetStorageLocalStorageService._internal();

  static GetStorageLocalStorageService get instance => (_instance != null) ? _instance! : _init();

  @override
  Future<void> init() async {
    await GetStorage.init();
    storageActive = true;
  }

  void guardClause() {
    assert(storageActive, 'CoreLocalStorage not initialized');
  }

  @override
  T read<T>(String key) {
    guardClause();
    return _storage.read(key);
  }

  @override
  bool hasData(String key) {
    guardClause();
    return _storage.hasData(key);
  }

  @override
  Future<void> write(String key, dynamic value) async {
    guardClause();
    return _storage.write(key, value);
  }

  @override
  void writeInMemory(String key, dynamic value) {
    guardClause();
    _storage.writeInMemory(key, value);
  }

  @override
  Future<void> remove(String key) async {
    guardClause();
    _storage.remove(key);
  }
}
