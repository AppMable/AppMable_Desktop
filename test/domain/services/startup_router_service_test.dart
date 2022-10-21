import 'package:appmable_desktop/domain/services/start_up_router_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:test/test.dart';

import '../model/value_objects/mock/barcode_search_result_mock.dart';
import 'storage/mock/local_storage_service_mock.dart';

void main() {
  group('Startup Router Service', () {

    test('Startup Router Service - User Not logged (existing data) --> Show Login Screen', () async {
      final LocalStorageService localStorageService = LocalStorageServiceMock();

      final StartUpRouterService startupRouterService = StartUpRouterService(
        localStorageService,
      );

      await localStorageService.write(LoginScreen.userInformation, null);

      final String route = await startupRouterService.execute();

      expect(route, equals(LoginScreen.routeName));
    });

    test('Startup Router Service - User Not logged (not existing data) --> Show Login Screen', () async {
      final LocalStorageService localStorageService = LocalStorageServiceMock();

      final StartUpRouterService startupRouterService = StartUpRouterService(
        localStorageService,
      );

      final String route = await startupRouterService.execute();

      expect(route, equals(LoginScreen.routeName));
    });

    test('Startup Router Service - User logged --> Show Dashboard Screen', () async {
      final LocalStorageService localStorageService = LocalStorageServiceMock();

      await localStorageService.write(LoginScreen.userInformation, userLoginInformationMockGenerator());

      final StartUpRouterService startupRouterService = StartUpRouterService(
        localStorageService,
      );

      final String route = await startupRouterService.execute();

      expect(route, equals(DashboardScreen.routeName));
    });
  });
}
