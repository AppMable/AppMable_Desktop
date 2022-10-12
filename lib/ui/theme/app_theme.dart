import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary600,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    hintColor: neutral200,
    errorColor: error600,
    shadowColor: complementary50,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: neutral800,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: neutral800,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: neutral200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      modalBackgroundColor: neutral800.withOpacity(0.65),
      elevation: 0,
    ),
    dialogBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: textStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      contentTextStyle: textStyle.copyWith(
        fontSize: 14,
      ),
    ),
    fontFamily: 'Manrope',
    textTheme: TextTheme(
      headline1: textStyle.copyWith(
        fontSize: 56,
      ),
      headline2: textStyle.copyWith(
        fontSize: 44,
      ),
      headline3: textStyle.copyWith(
        fontSize: 36,
      ),
      headline4: textStyle.copyWith(
        fontSize: 24,
      ),
      headline5: textStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline6: textStyle.copyWith(
        fontSize: 16,
      ),
      bodyText1: textStyle.copyWith(
        fontSize: 16,
      ),
      bodyText2: textStyle.copyWith(
        fontSize: 14,
      ),
      button: textStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      caption: textStyle.copyWith(
        fontSize: 12,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        animationDuration: Duration.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: secondary600,
        elevation: 0,
        minimumSize: const Size.fromHeight(44),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: neutral10,
        backgroundColor: neutral400,
        elevation: 0,
        minimumSize: const Size.fromHeight(44),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: const BorderSide(
          color: neutral10,
        ),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primary50,
      inactiveTrackColor: primary600,
      thumbColor: primary800,
      //thumbShape: ,
      trackHeight: 1,
      overlayColor: primary600.withOpacity(0.35),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else if (states.contains(MaterialState.disabled)) {
          return neutral800;
        } else {
          return Colors.transparent;
        }
      }),
      overlayColor: MaterialStateProperty.resolveWith((states) => primary200),
    ),
  );

  static const textStyle = TextStyle(
    color: Colors.black,
    letterSpacing: -.2,
  );

  static const boxShadow = [
    BoxShadow(
      color: shadow,
      offset: Offset(0, 2),
      blurRadius: 6,
    ),
  ];

  static const Color primary900 = Color(0xFFFFB300);
  static const Color primary800 = Color(0xFFFDB815);
  static const Color primary600 = Color(0xFFFDBF2F);
  static const Color primary400 = Color(0xFFFFCE5C);
  static const Color primary200 = Color(0xFFFFDA83);
  static const Color primary50 = Color(0xFFFFEDC4);
  static const Color primary25 = Color(0xFFFFF7E6);

  static const Color secondary900 = Color(0xFF00D6FD);
  static const Color secondary800 = Color(0xFF1DDCFD);
  static const Color secondary600 = Color(0xFF3BE2FF);
  static const Color secondary400 = Color(0xFF61E7FF);
  static const Color secondary200 = Color(0xFF7DECFF);
  static const Color secondary50 = Color(0xFFC7F7FF);
  static const Color secondary25 = Color(0xFFE6FBFF);

  static const Color complementary900 = Color(0xFFF00C67);
  static const Color complementary800 = Color(0xFFFF1E78);
  static const Color complementary600 = Color(0xFFFF3A89);
  static const Color complementary400 = Color(0xFFFF63A1);
  static const Color complementary200 = Color(0xFFFF7DB1);
  static const Color complementary50 = Color(0xFFFFC3DB);
  static const Color complementary25 = Color(0xFFFFE5EF);

  static const Color error600 = Color.fromRGBO(211, 30, 30, 1);

  static const Color neutral900 = Color(0xff131415);
  static const Color neutral800 = Color(0xff3a3d40);
  static const Color neutral600 = Color(0xff5f6368);
  static const Color neutral400 = Color(0xff898e94);
  static const Color neutral200 = Color(0xffb4b7bb);
  static const Color neutral100 = Color(0xf0d1d5db);
  static const Color neutral50 = Color(0xffeaeaec);
  static const Color neutral10 = Color(0xffffffff);

  static const Color shadow = Color(0x335f6368);
  static const Color nativeButton = Color(0xff007aff);
  static const Color disabled200 = Color(0xff757783);

  static const int smallDeviceWidth = 321; // iPhone SE Gen1
  static const int smallDeviceWidthGen2 = 375; // iPhone SE Gen2
  static const int smallDeviceHeight = 593; // iPhone SE Gen1
  static const int smallDeviceHeightGen2 = 667; // iPhone SE Gen2
  static const int iphoneXHeight = 896; // Iphone X Height
  static const int iphone12Height = 840; // Iphone 12 Height
}
