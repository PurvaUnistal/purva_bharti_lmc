import 'package:flutter/material.dart';
import 'package:lmc/style/colors.dart';
import '../../ExportFile/export_file.dart';

final ThemeData kDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff222222),
  accentColorBrightness: Brightness.dark,
  primaryColor: AppColor.accent,
  accentIconTheme: IconThemeData(
    color: AppColor.accent,
  ),
  accentColor: AppColor.accent,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green.shade800,
    color: Color(0xff333333),
    brightness: Brightness.dark,
    iconTheme: IconThemeData(
      color: AppColor.accent,
    ),
  ),
  iconTheme: IconThemeData(
    color: AppColor.accent,
  ),
  fontFamily: "Montserrat",
);

final ThemeData kLightThemeData = ThemeData(
  canvasColor: AppColor.background,
  accentColor: AppColor.accent,
  errorColor: AppColor.error,
  // ignore: deprecated_member_use
  buttonColor: AppColor.primaryVariant,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  iconTheme: IconThemeData(
    color: AppColor.accent,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green.shade800,
    color: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: AppColor.accent,
    ),
  ),
  fontFamily: "Montserrat",
);
