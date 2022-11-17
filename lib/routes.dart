import 'package:appmable_desktop/domain/services/start_up_service.dart';
import 'package:appmable_desktop/ui/screens/alerts/alerts_users_screen/alerts_users_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/contacts_users_screen/contacts_users_screen.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/screens/splash_screen/splash_screen.dart';
import 'package:appmable_desktop/ui/screens/splash_screen/widgets/splash_holder.dart';
import 'package:appmable_desktop/ui/screens/users/create_user_screen/create_user_screen.dart';
import 'package:appmable_desktop/ui/screens/users/update_user_screen/update_user_screen.dart';
import 'package:appmable_desktop/ui/screens/users/users_screen/users_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/create_contact_screen/create_contact_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/update_contact_screen/update_contact_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/contacts_screen/contacts_screen.dart';
import 'package:appmable_desktop/ui/screens/alerts/create_alert_screen/create_alert_screen.dart';
import 'package:appmable_desktop/ui/screens/alerts/update_alert_screen/update_alert_screen.dart';
import 'package:appmable_desktop/ui/screens/alerts/alerts_screen/alerts_screen.dart';
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
    // Users section
    UsersScreen.routeName: (_) => UsersScreen(),
    CreateUserScreen.routeName: (_) => const CreateUserScreen(),
    UpdateUserScreen.routeName: (_) => const UpdateUserScreen(),
    // Contacts section
    ContactsUsersScreen.routeName: (_) => ContactsUsersScreen(),
    ContactsScreen.routeName: (_) => ContactsScreen(),
    CreateContactScreen.routeName: (_) => const CreateContactScreen(),
    UpdateContactScreen.routeName: (_) => const UpdateContactScreen(),
    // Alerts section
    AlertsUsersScreen.routeName: (_) => AlertsUsersScreen(),
    AlertsScreen.routeName: (_) => AlertsScreen(),
    CreateAlertScreen.routeName: (_) => const CreateAlertScreen(),
    UpdateAlertScreen.routeName: (_) => const UpdateAlertScreen(),
  };

  return routes;
}

final routes = _routeGenerator();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
