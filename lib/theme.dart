import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: Colors.white,
    appBarTheme: appBarTheme(),
    // textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: Color(0xFF757575)),
    bodyText2: TextStyle(color: Color(0xFF757575)),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}