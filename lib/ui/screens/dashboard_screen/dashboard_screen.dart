import 'dart:io' show Platform;

import 'package:appmable_desktop/application/bloc/login_screen/login_screen_bloc.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/screens/users_screen/users_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showIncorrectLogOutError = false;
  String logOutErrorMessage = '';

  final LoginScreenBloc _loginScreenBloc = GetIt.instance.get<LoginScreenBloc>();

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
}
