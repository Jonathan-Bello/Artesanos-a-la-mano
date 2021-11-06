import 'package:flutter/material.dart';

final miTemaA = ThemeData(
  primaryColor: Colors.purple,
  accentColor: Colors.yellowAccent,
  hoverColor: Colors.purple[700],
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.purple,
    textStyle: TextStyle(
      color: Colors.white,
    ),
    shape: StadiumBorder(),
  )),
  fixTextFieldOutlineLabel: false,
  colorScheme: ColorScheme(
    primary: Colors.purple,
    primaryVariant: Colors.purple[700],
    secondary: Colors.yellowAccent,
    secondaryVariant: Colors.yellowAccent[700],
    surface: Colors.white30,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  iconTheme: IconThemeData(
    color: Colors.black87,
    //size: 30.0
  ),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  backgroundColor: Colors.white,
  shadowColor: Colors.black26,
  // cursorColor:
);
