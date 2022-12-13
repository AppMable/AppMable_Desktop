import 'package:appmable_desktop/application/bloc/login_screen/login_screen_bloc.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:get_it/get_it.dart';

class NotPermissionsScreen extends StatefulWidget {
  static const routeName = '/not_permissions_screen';

  const NotPermissionsScreen({
    super.key,
  });

  @override
  State<NotPermissionsScreen> createState() => _NotPermissionsScreenState();
}

class _NotPermissionsScreenState extends State<NotPermissionsScreen> {
  bool showIncorrectLogOutError = false;
  String logOutErrorMessage = '';

  final LoginScreenBloc _loginScreenBloc = GetIt.instance.get<LoginScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary200,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                width: 100,
                height: 100,
                image: AssetImage(
                  'assets/images/splashBranding.png',
                ),
              ),
            ),
            const SizedBox(height: 100),
            const Text(
              'No puedes acceder',
              style: TextStyle(color: AppTheme.error600),
            ),
            const SizedBox(height: 25),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                overlayColor: MaterialStateProperty.all<Color>(AppTheme.primary900),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(width: 1, color: Colors.black),
                  ),
                ),
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
                'Cerrar Sessión',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
