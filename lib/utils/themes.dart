import 'package:flutter/material.dart';

///////////////////////////////////////////////////////////////////
const lightMainColor = Color.fromARGB(255, 252, 253, 255);
const lightSecondColor = Color.fromARGB(255, 8, 83, 212);
const lightThirdlyColor = Color.fromARGB(255, 0, 0, 0);
///////////////////////////////////////////////////////////////////
const darkMainColor = Color.fromARGB(255, 25, 25, 25);
const darkSecondColor = Color.fromARGB(255, 55, 115, 219);
const darkThirdlyColor = Color.fromARGB(255, 255, 255, 255);

///////////////////////////////////////////////////////////////////
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  cardColor: lightThirdlyColor,
  appBarTheme: const AppBarTheme(
    color: lightMainColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: lightThirdlyColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
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
      color: darkThirdlyColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
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
