import 'package:flutter/material.dart';

const accentColor = Color(0xFF8E6CEF);
///////////////////////////////////////////////////////////////////
const lightMainColor = Color(0xFFFFFFFF);
const lightOnPrimaryColor = Colors.black;
const lightNeutralColor = Color(0xFFF4F4F4);
///////////////////////////////////////////////////////////////////
const darkMainColor = Color(0xFF1D182A);
const darkOnPrimaryColor = Colors.white;
const darkNeutralColor = Color(0xFF342F3F);

///////////////////////////////////////////////////////////////////
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: "oswald",
  primaryColor: lightMainColor,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: accentColor,
    selectionColor: lightOnPrimaryColor.withOpacity(0.25),
    selectionHandleColor: accentColor,
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: lightMainColor),
  scaffoldBackgroundColor: lightMainColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: lightMainColor,
  ),
  colorScheme: const ColorScheme.light(
    primary: lightMainColor,
    onPrimary: lightOnPrimaryColor,
    tertiary: lightNeutralColor,
    secondary: accentColor,
  ),
);
///////////////////////////////////////////////////////////////
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: "oswald",
  drawerTheme: const DrawerThemeData(backgroundColor: darkMainColor),
  appBarTheme: const AppBarTheme(
    backgroundColor: darkMainColor,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: accentColor,
    selectionColor: darkOnPrimaryColor.withOpacity(0.25),
    selectionHandleColor: accentColor,
  ),
  primaryColor: darkMainColor,
  scaffoldBackgroundColor: darkMainColor,
  colorScheme: const ColorScheme.dark(
    primary: darkMainColor,
    onPrimary: darkOnPrimaryColor,
    tertiary: darkNeutralColor,
    secondary: accentColor,
  ),
);
