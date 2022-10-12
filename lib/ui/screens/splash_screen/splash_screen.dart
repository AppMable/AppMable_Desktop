import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary200,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Image(
                width: 100,
                height: 100,
                image: AssetImage(
                  'assets/images/splashBranding.png',
                ),
              ),
            ),
            SizedBox(height: 100),
            CircularProgressIndicator(
              color: AppTheme.primary600,
            ),
          ],
        ),
      ),
    );
  }
}
