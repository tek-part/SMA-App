import 'package:flutter/material.dart';

const Color mainColor = Color.fromARGB(255, 245, 232, 187);

// MaterialColor for primarySwatch based on mainColor
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

final MaterialColor mainColorSwatch = createMaterialColor(mainColor);
// ignore: constant_identifier_names
const Color GreyClr = Color(0xFF888888);
const Color darkGreyClr = Color(0xFF121212);
const Color greenClr = Color(0xFF4FC028);
const Color recGreyClr = Color(0xFFEB001B);

const Color pinkClr = Color(0xFFff4667);
const Color callClr = Color(0xFF180E2B);
const Color orngClr = Color(0xFFD48D39);
const Color scendrycolor = Color(0xFFFFF0C2);
const Color kCOlor4 = Color(0xff738B71);
const Color kCOlor5 = Color(0xff6D454D);
const Color darkSettings = Color(0xff6138e4);
const Color accountSettings = Color(0xff73bc65);
const Color logOutSettings = Color(0xff5f95ef);
const Color notiSetting = Color(0xffdf5862);
const Color languageSettings = Color(0xffCB256C);

// ignore: camel_case_types
class themsApp {
  static final light = ThemeData(
      primarySwatch: mainColorSwatch,
      primaryColor: mainColor,
      // ignore: deprecated_member_use
      hintColor: mainColor,
      scaffoldBackgroundColor: Colors.white,

      // ignore: deprecated_member_use
      // backgroundColor: Colors.white,
      brightness: Brightness.light);
  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    // ignore: deprecated_member_use
    // backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
