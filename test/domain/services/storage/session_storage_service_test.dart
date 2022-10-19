import 'package:flutter_test/flutter_test.dart';
import 'package:appmable_desktop/domain/services/storage/session_storage_service.dart';

import 'mock/local_storage_service_mock.dart';

void main() {
  group('Session Storage Service Test', () {
    final SessionStorageService sessionStorageService = SessionStorageService(
      LocalStorageServiceMock(),
    );
    
    test('Session Storage Service Test - first initialization', () async {
      assert(sessionStorageService.currentSession == 0, 'The current session must be 0');
    });

    test('Session Storage Service Test - increase session', () async {
      sessionStorageService.increaseSession();
      assert(sessionStorageService.currentSession == 1, 'The current session must be 1');
    });

    test('Session Storage Service Test - increasing more sessions', () async {
      sessionStorageService
        ..increaseSession()
        ..increaseSession()
        ..increaseSession()
        ..increaseSession();
      assert(sessionStorageService.currentSession == 5, 'The current session must be 5');
    });
  });
}
