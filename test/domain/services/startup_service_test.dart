import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:appmable_desktop/domain/services/start_up_router_service.dart';
import 'package:appmable_desktop/domain/services/start_up_service.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'startup_service_test.mocks.dart';
import 'storage/mock/local_storage_service_mock.dart';

@GenerateMocks([
  StartUpRouterService,
  EncrypterService,
])
void main() {
  group('Startup service', () {
    test('Startup Test', () async {
      final Faker faker = Faker();

      final StartUpRouterService startupRouterService = MockStartUpRouterService();
      final LocalStorageServiceMock localStorageService = LocalStorageServiceMock();
      final EncrypterService encrypterService = MockEncrypterService();

      final String returnPageRoute = '/${faker.lorem.words(2).join('-')}';

      when(startupRouterService.execute()).thenAnswer((_) => Future.value(returnPageRoute));

      final StartUpService startupService = StartUpService(
        startupRouterService,
        localStorageService,
        encrypterService,
      );

      final route = await startupService.execute();

      expect(route, equals(returnPageRoute));

      verify(startupRouterService.execute()).called(1);
    });
  });
}
