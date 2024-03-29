import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/navigation_button.dart';
import 'package:appmable_desktop/ui/common/mixin/user_mixin.dart';
import 'package:appmable_desktop/ui/screens/alerts/alerts_screen/alerts_screen.dart';
import 'package:appmable_desktop/ui/screens/alerts/alerts_users_screen/alerts_users_screen.dart';
import 'package:appmable_desktop/ui/screens/alerts/create_alert_screen/create_alert_screen.dart';
import 'package:appmable_desktop/ui/screens/alerts/update_alert_screen/update_alert_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/contacts_screen/contacts_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/contacts_users_screen/contacts_users_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/create_contact_screen/create_contact_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/update_contact_screen/update_contact_screen.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen_super_admin/dashboard_screen_super_admin.dart';
import 'package:appmable_desktop/ui/screens/users/create_user_screen/create_user_screen.dart';
import 'package:appmable_desktop/ui/screens/users/update_user_screen/update_user_screen.dart';
import 'package:appmable_desktop/ui/screens/users/users_screen/users_screen.dart';
import 'package:flutter/material.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  const NavigationPanel({Key? key, required this.axis}) : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> with UserMixin {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    final User user = getUser();

    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
          : const EdgeInsets.all(10),
      child: widget.axis == Axis.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/images/splashBranding.png", height: 50),
                Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  NavigationButton(
                    onPressed: () => user.isTutor
                        ? Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName)
                        : Navigator.of(context).pushReplacementNamed(DashboardScreenSuperAdmin.routeName),
                    icon: Icons.home,
                    isActive: user.isTutor
                        ? ModalRoute.of(context)!.settings.name == DashboardScreen.routeName
                        : ModalRoute.of(context)!.settings.name == DashboardScreenSuperAdmin.routeName,
                  ),
                  user.isTutor
                      ? NavigationButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed(UsersScreen.routeName),
                          icon: Icons.supervised_user_circle_outlined,
                          isActive: ModalRoute.of(context)!.settings.name == UsersScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == CreateUserScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == UpdateUserScreen.routeName,
                        )
                      : const SizedBox.shrink(),
                  user.isTutor
                      ? NavigationButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed(ContactsUsersScreen.routeName),
                          isActive: ModalRoute.of(context)!.settings.name == ContactsUsersScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == ContactsScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == CreateContactScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == UpdateContactScreen.routeName,
                          icon: Icons.people,
                        )
                      : const SizedBox.shrink(),
                  user.isTutor
                      ? NavigationButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed(AlertsUsersScreen.routeName),
                          isActive: ModalRoute.of(context)!.settings.name == AlertsUsersScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == AlertsScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == CreateAlertScreen.routeName ||
                              ModalRoute.of(context)!.settings.name == UpdateAlertScreen.routeName,
                          icon: Icons.add_alert_outlined,
                        )
                      : const SizedBox.shrink(),
                  user.isTutor
                      ? NavigationButton(
                          onPressed: () {},
                          icon: Icons.calendar_month_outlined,
                        )
                      : const SizedBox.shrink(),
                ]),
                Container()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logo.png", height: 20),
                Row(
                  children: [
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.supervised_user_circle_outlined,
                    ),
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.medical_information_outlined,
                    ),
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.add_alert_outlined,
                    ),
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.calendar_month_outlined,
                    ),
                  ],
                ),
                Container()
              ],
            ),
    );
  }
}
