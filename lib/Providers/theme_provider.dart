import 'package:flutter/material.dart';
import 'package:readable/constants.dart';

class ThemeProvider extends ChangeNotifier {
  late String fontFamily;
  late int accentColor;

  ThemeProvider() {
    fontFamily = FONT_NAME;
    accentColor = ACCENT_COLOR;
  }
}
