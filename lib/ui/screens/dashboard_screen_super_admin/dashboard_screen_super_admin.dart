import 'package:appmable_desktop/application/bloc/dashboard_screen_super_admin/dashboard_screen_super_admin_bloc.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DashboardScreenSuperAdmin extends StatefulWidget {
  static const String routeName = '/dashboard_super_admin';

  const DashboardScreenSuperAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardScreenSuperAdmin> createState() => _DashboardScreenSuperAdminState();
}

class _DashboardScreenSuperAdminState extends State<DashboardScreenSuperAdmin> {

  final DashboardScreenSuperAdminBloc _dashboardScreenSuperAdminBloc = GetIt.instance.get<
      DashboardScreenSuperAdminBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DashboardScreenSuperAdminBloc, DashboardScreenSuperAdminState>(
          bloc: _dashboardScreenSuperAdminBloc,
          builder: (context, state) {
            if(state is DashboardScreenSuperAdminLoaded){
              return AppLayout(
                title: 'Dasboard',
                content: Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Text('Users'),
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
            _dashboardScreenSuperAdminBloc.add(const DashboardScreenSuperAdminEventLoad());
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
