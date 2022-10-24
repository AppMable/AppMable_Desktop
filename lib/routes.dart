import 'package:appmable_desktop/domain/services/start_up_service.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/screens/splash_screen/splash_screen.dart';
import 'package:appmable_desktop/ui/screens/splash_screen/widgets/splash_holder.dart';
import 'package:appmable_desktop/ui/screens/users/create_user_screen/create_user_screen.dart';
import 'package:appmable_desktop/ui/screens/users/users_screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Map<String, WidgetBuilder> _routeGenerator() {
  final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (_) => SplashHolder(
      splashWidget: const SplashScreen(),
      postInitDecisionFunction: () {
        return GetIt.I.get<StartUpService>().execute();
      },
    ),
    LoginScreen.routeName: (_) => LoginScreen(),
    DashboardScreen.routeName: (_) => const DashboardScreen(),
    UsersScreen.routeName: (_) => UsersScreen(),
    CreateUserScreen.routeName: (_) => CreateUserScreen(),
  };

  return routes;
}

final routes = _routeGenerator();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
