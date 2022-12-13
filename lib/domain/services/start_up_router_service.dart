import 'dart:convert';

import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen_super_admin/dashboard_screen_super_admin.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/screens/not_permissions_screen/not_permissions_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartUpRouterService {
  final LocalStorageService _localStorageService;

  const StartUpRouterService(
    this._localStorageService,
  );

  Future<String> execute() async {
    final String? userLoginInformationEncoded = _localStorageService.read(LoginScreen.userLoginInformation);

    final UserLoginInformation? userLoginInformation = userLoginInformationEncoded != null
        ? UserLoginInformation.fromMap(jsonDecode(userLoginInformationEncoded))
        : null;

    String route;

    if (userLoginInformation == null) {
      route = LoginScreen.routeName;
    } else if (userLoginInformation.isSuperAdmin) {
      route = DashboardScreenSuperAdmin.routeName;
    } else if(userLoginInformation.isTutor){
      route = DashboardScreen.routeName;
    } else {
      route = NotPermissionsScreen.routeName;
    }

    return route;
  }
}
