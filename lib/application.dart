import 'package:flutter/material.dart';
import 'package:appmable_desktop/routes.dart';
import 'package:appmable_desktop/ui/screens/onboarding_screen/onboarding_screen.dart';

class ButtonYuki extends StatelessWidget {
  const ButtonYuki({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: OnboardingScreen.routeName,
      routes: routes,
    );
  }
}
