import 'package:appmable_desktop/domain/services/navigator_service.dart';
import 'package:appmable_desktop/ui/screens/splash_screen/splash_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:appmable_desktop/routes.dart';
import 'package:get_it/get_it.dart';

class AppMable extends StatelessWidget {
  const AppMable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.routeName,
      navigatorKey: GetIt.instance.get<NavigatorService>().navigatorKey,
      theme:
      AppTheme.lightTheme.copyWith(colorScheme: AppTheme.lightTheme.colorScheme.copyWith(secondary: Colors.white)),
      routes: routes,
    );
  }
}
