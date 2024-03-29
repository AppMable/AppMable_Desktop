import 'package:appmable_desktop/application/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
import 'package:appmable_desktop/ui/screens/alerts/alerts_users_screen/alerts_users_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/contacts_users_screen/contacts_users_screen.dart';
import 'package:appmable_desktop/ui/screens/users/users_screen/users_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'widgets/dashboard_button.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardScreenBloc _dashboardScreenBloc = GetIt.instance.get<DashboardScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
          bloc: _dashboardScreenBloc,
          builder: (context, state) {
            if (state is DashboardScreenLoaded) {
              return AppLayout(
                title: 'Dasboard',
                content: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).pushReplacementNamed(UsersScreen.routeName),
                                    child: const DashboardButton(
                                      title: 'Tutelados',
                                      icon: Icons.supervised_user_circle_outlined,
                                      backgroundColor: AppTheme.primary900,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () =>
                                        Navigator.of(context).pushReplacementNamed(ContactsUsersScreen.routeName),
                                    child: const DashboardButton(
                                      title: 'Contactos',
                                      icon: Icons.people,
                                      backgroundColor: AppTheme.secondary900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () =>
                                        Navigator.of(context).pushReplacementNamed(AlertsUsersScreen.routeName),
                                    child: const DashboardButton(
                                      title: 'Alarmas',
                                      icon: Icons.add_alert_outlined,
                                      backgroundColor: AppTheme.complementary900,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  flex: 2,
                                  child: DashboardButton(
                                    title: 'Eventos',
                                    icon: Icons.calendar_month_outlined,
                                    backgroundColor: AppTheme.neutral400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: Responsive.isDesktop(context),
                      child: Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: Styles.defaultPadding),
                          child: Column(
                            children: const [
                              Expanded(
                                child: UserInfo(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            _dashboardScreenBloc.add(const DashboardScreenEventLoad());
            return Column(
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Cargando...',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 20),
                    Center(child: CircularProgressIndicator(color: AppTheme.primary900)),
                    SizedBox(height: 50),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
