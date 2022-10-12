import 'dart:async';

import 'package:appmable_desktop/domain/services/navigator_service.dart';
import 'package:flutter/material.dart';

typedef PostInitDecisionFunction = FutureOr<String> Function();
typedef PostFailedInitDecisionFunction = FutureOr<String> Function();

class SplashHolder extends StatelessWidget {
  final NavigatorService _navigatorService;
  final Widget splashWidget;
  final PostInitDecisionFunction postInitDecisionFunction;

  SplashHolder({
    super.key,
    required this.splashWidget,
    required this.postInitDecisionFunction,
    NavigatorService? navigatorService,
  }) : _navigatorService = navigatorService ?? NavigatorService.instance {
    WidgetsBinding.instance.addPostFrameCallback(_startupApp);
  }

  Future<void> _startupApp(Duration timeStamp) async {
    try {
      final FutureOr<String> routeOr = postInitDecisionFunction();
      if (routeOr is Future<String>) {
        final route = await routeOr;
        _navigatorService.pushReplacementNamed(route);
      } else {
        _navigatorService.pushReplacementNamed(routeOr);
      }
    } catch (_) {
      throw Error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return splashWidget;
  }
}
