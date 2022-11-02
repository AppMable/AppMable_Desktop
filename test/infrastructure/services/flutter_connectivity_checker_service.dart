import 'package:appmable_desktop/infrastructure/services/flutter_connectivity_checker_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'flutter_connectivity_checker_service.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  group('Tests over Connectivity', () {
    final Connectivity connectivity = MockConnectivity();
    final FlutterConnectivityCheckerService service = FlutterConnectivityCheckerService(connectivity);

    test('ConnectivityResult.wifi', () async {
      when(connectivity.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.wifi));
      assert(await service.hasConnection());
    });

    test('ConnectivityResult.mobile', () async {
      when(connectivity.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.mobile));
      assert(await service.hasConnection());
    });

    test('ConnectivityResult.ethernet', () async {
      when(connectivity.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.ethernet));
      assert(await service.hasConnection());
    });

    test('ConnectivityResult.none', () async {
      when(connectivity.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.none));
      assert(await service.hasConnection() == false);
    });

    test('ConnectivityResult.bluetooth', () async {
      when(connectivity.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.bluetooth));
      assert(await service.hasConnection() == false);
    });
  });
}
