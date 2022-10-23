import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'widgets/dashboard_button.dart';
part 'widgets/user_info.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
        scrollbarTheme: Styles.scrollbarTheme,
      ),
      home: Scaffold(
        body: SafeArea(
          child: AppLayout(
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
                                onTap: () => print('tapped'),
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
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: (Platform.isAndroid) ? Colors.black : Colors.white),
        child: Container(
          color: Colors.black.withOpacity(0.80),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2596be)),
                  ),
                  onPressed: () {
                    _loginScreenBloc.add(LogOutEvent(
                      onLogOutSuccess: () {
                        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                      },
                      onLogOutError: (String error) {
                        setState(() {
                          showIncorrectLogOutError = true;
                          logOutErrorMessage = error;
                        });
                      },
                    ));
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                showIncorrectLogOutError
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            logOutErrorMessage,
                            style: const TextStyle(color: AppTheme.error600),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 50),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(UsersScreen.routeName);
                  },
                  icon: const Icon(Icons.people_alt_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   */
}
