import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';

@injectable
class SessionStorageService {
  static const String _sessionKey = 'SESSION_COUNTER';

  final LocalStorageService _localStorageService;

  const SessionStorageService(this._localStorageService);

  int get currentSession => _localStorageService.read(_sessionKey) ?? 0;

  Future<void> increaseSession() {
    return _localStorageService.write(
      _sessionKey,
      currentSession + 1,
    );
  }
}
