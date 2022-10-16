import 'package:appmable_desktop/domain/services/connectivity_checker_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
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
    const bool isLogged = false;

    String route;

    if (!isLogged) {
      route = LoginScreen.routeName;
    } else {
      route = MainScreen.routeName;
    }

    return route;
  }
}
