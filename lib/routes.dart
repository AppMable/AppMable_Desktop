import 'package:flutter/material.dart';
import 'package:appmable_desktop/ui/screens/main_screen/main_screen.dart';
import 'package:appmable_desktop/ui/screens/onboarding_screen/onboarding_screen.dart';

Map<String, WidgetBuilder> _routeGenerator() {
  final Map<String, WidgetBuilder> routes = {
    OnboardingScreen.routeName: (_) => const OnboardingScreen(),
    MainScreen.routeName: (_) => MainScreen(),
  };

  return routes;
}

final routes = _routeGenerator();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
