import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartUpRouterService {
  final LocalStorageService _localStorageService;

  const StartUpRouterService(
    this._localStorageService,
  );

  Future<String> execute() async {
    final bool isLogged = _localStorageService.hasData(LoginScreen.userInformation);

    String route;

    if (!isLogged) {
      route = LoginScreen.routeName;
    } else {
      route = DashboardScreen.routeName;
    }

    return route;
  }
}
