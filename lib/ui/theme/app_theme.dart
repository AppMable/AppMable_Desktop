import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    hintColor: primary,
    errorColor: primary,
    shadowColor: primary,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: primary,
    ),
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline1: textStyle.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 41,
      ),
      headline2: textStyle.copyWith(
        fontSize: 34,
      ),
      headline3: textStyle.copyWith(
        fontSize: 27,
      ),
      bodyText1: textStyle.copyWith(
        fontSize: 22,
      ),
      bodyText2: textStyle.copyWith(
        fontSize: 14,
      ),
      caption: textStyle.copyWith(
        fontSize: 12,
      ),
    ),
  );

  static const textStyle = TextStyle(
    color: Colors.black,
    letterSpacing: -.2,
  );

  static const Color primary = Color(0xff000000);
  static const Color secondary = Color(0xff515151);

  static const Color primaryButton = Colors.greenAccent;
  static const Color secondaryButton = Colors.lightGreenAccent;
}