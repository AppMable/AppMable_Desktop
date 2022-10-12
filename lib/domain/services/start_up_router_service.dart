import 'package:appmable_desktop/domain/services/connectivity_checker_service.dart';
import 'package:appmable_desktop/ui/screens/main_screen/main_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartUpRouterService {
  final ConnectivityCheckerService _connectivityCheckerService;

  const StartUpRouterService(
    this._connectivityCheckerService,
  );

  Future<String> execute() async {

    final bool hasConnectivity = await _connectivityCheckerService.hasConnection();

    await Future<void>.delayed(const Duration(milliseconds: 5000));

    String route;

    if (hasConnectivity) {
      route = MainScreen.routeName;
    } else {
      route = MainScreen.routeName;
    }

    return route;
  }
}
