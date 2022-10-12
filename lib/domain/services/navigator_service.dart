import 'package:flutter/material.dart';

class NavigatorService {
  static NavigatorService? _instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorService._internal();
  static NavigatorService _init() => _instance = NavigatorService._internal();
  static NavigatorService get instance => (_instance != null) ? _instance! : _init();

  Future<dynamic> push(Widget widget) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (_) => Material(
          child: widget,
        ),
      ),
    );
  }

  Future<dynamic> pushReplacement(
    Widget widget, {
    bool isPopping = false,
  }) {
    return navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, a1, a2) => Material(
          child: widget,
        ),
        transitionsBuilder: (context, animation, a2, child) => SlideTransition(
          position: Tween<Offset>(
            begin: isPopping ? const Offset(-1, 0) : const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
    );
  }

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushReplacementNamed(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }

  Future<void> popAndPushNamed<TO extends Object>(
    String route, {
    TO? result,
    Object? arguments,
  }) async {
    await navigatorKey.currentState!.popAndPushNamed(route, result: result, arguments: arguments);
  }
}
