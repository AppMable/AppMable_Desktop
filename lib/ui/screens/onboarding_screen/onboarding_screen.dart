import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appmable_desktop/ui/common/widgets/appmable_logo.dart';
import 'package:appmable_desktop/ui/screens/main_screen/main_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: (Platform.isAndroid) ? Colors.black : Colors.white),
        child: Container(
          color: Colors.black.withOpacity(0.80),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppMableLogo(),
                const SizedBox(height: 50),
                const Text(
                  'Bienvenido \n a nuestra app',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 152),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: AppTheme.primary900, elevation: 3,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
