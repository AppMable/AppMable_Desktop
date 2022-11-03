import 'package:appmable_desktop/application/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/login_screen/login_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/mixin/user_mixin.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/widgets/change_password_button.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/screens/users/users_screen/users_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'widgets/dashboard_button.dart';
part 'widgets/user_info.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  static const userInformation = 'userInformation';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: AppLayout(
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
                          const Expanded(
                            flex: 2,
                            child: DashboardButton(
                              title: 'Medicinas',
                              icon: Icons.medical_information_outlined,
                              backgroundColor: AppTheme.secondary900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: DashboardButton(
                              title: 'Alarmas',
                              icon: Icons.add_alert_outlined,
                              backgroundColor: AppTheme.complementary900,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
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
        ),
      ),
    );
  }
}
