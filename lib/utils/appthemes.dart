import 'package:flutter/material.dart';

class Appthemes{

  static final Color primaryColor = Color(0xFFDDEA38);
  static final Color backgroundColor = Color(0xFF000000);
  static final Color cardColor = Color(0xFF1C1C1C);
  static final Color bottomNavBarColor = Color(0xFF333333);
  static final Color whiteColor = Colors.white;
  static final Color secondaryTextColor = Color(0xFFAAAAAA);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: whiteColor,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: whiteColor),
      bodyText1: TextStyle(fontSize: 16, color: whiteColor),
      bodyText2: TextStyle(fontSize: 14, color: secondaryTextColor),
      button: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      labelStyle: TextStyle(
        color: primaryColor,
      ),
    ),
  );
}