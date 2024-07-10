import 'package:flutter/material.dart';

///////////////////////////////////////////////////////////////////
const lightMainColor = Color(0xFFFFFFFF);
const lightSecondColor = Color(0xFF8E6CEF);
const lightThirdlyColor = Color(0xFFF4F4F4);
///////////////////////////////////////////////////////////////////
const darkMainColor = Color(0xFF1D182A);
const darkSecondColor = Color(0xFF8E6CEF);
const darkThirdlyColor = Color(0xFF342F3F);

///////////////////////////////////////////////////////////////////
ThemeData lightMode = ThemeData(
  //iconTheme: IconThemeData(color: Colors),
  brightness: Brightness.light,
  cardColor: lightThirdlyColor,
  appBarTheme: const AppBarTheme(
    color: lightMainColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  ),
  primaryColor: lightMainColor,
  scaffoldBackgroundColor: lightMainColor,
  colorScheme: const ColorScheme.light(
    primary: lightMainColor,
    tertiary: lightThirdlyColor,
    secondary: lightSecondColor,
  ),
);
///////////////////////////////////////////////////////////////
ThemeData darkMode = ThemeData(
  appBarTheme: const AppBarTheme(
    color: darkMainColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: darkMainColor,
  scaffoldBackgroundColor: darkMainColor,
  colorScheme: const ColorScheme.dark(
    primary: darkMainColor,
    tertiary: darkThirdlyColor,
    secondary: darkSecondColor,
  ),
);
