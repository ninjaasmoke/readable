import 'package:flutter/material.dart';
import 'package:readable/constants.dart';

ThemeData darkTheme = ThemeData(
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  fontFamily: FONT_NAME,
  colorScheme: const ColorScheme(
    background: Colors.black,
    primary: Colors.white,
    secondary: Color(0xff141418),
    surface: Colors.black,
    error: Color(ACCENT_COLOR),
    onBackground: Colors.white,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff141418),
  ),
);
