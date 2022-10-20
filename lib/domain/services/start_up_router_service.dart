import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/screens/main_screen/main_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartUpRouterService {
  final LocalStorageService _localStorageService;

  const StartUpRouterService(
    this._localStorageService,
  );

  Future<String> execute() async {
    final bool isLogged = _localStorageService.read(LoginScreen.userInformation) ?? false;

    String route;

    if (!isLogged) {
      route = LoginScreen.routeName;
    } else {
      route = MainScreen.routeName;
    }

    return route;
  }
}
