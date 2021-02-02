import 'package:flutter/material.dart';

final themeStarColor = Colors.yellow;

final ratingStarTheme = IconThemeData(color: Colors.orangeAccent, size: 25);

const double appBorderRadius = 20.0;

final ***REMOVED***LightTheme = ThemeData(
    backgroundColor: Colors.white,

    /// -- Colors -- ///
    primaryColor: Colors.black,
    primaryColorLight: Colors.grey,
    accentColor: Colors.orange,
    focusColor: Colors.orange,

    /// -- bottom bar -- ///
    primaryTextTheme: TextTheme(
      headline3: TextStyle(
          fontFamily: "Playfair_Display", color: Colors.black, fontSize: 33),
      headline5: TextStyle(
          fontFamily: "Playfair_Display", color: Colors.black, fontSize: 20),
      headline6: TextStyle(
          fontFamily: "Playfair_Display", color: Colors.black, fontSize: 15),
      bodyText1: TextStyle(
        fontFamily: "Playfair_Display",
        color: Colors.black,
        fontSize: 20,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appBorderRadius),
      ),
    ),

    /// -- bottom bar -- ///
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        elevation: 10,
        selectedIconTheme: IconThemeData(color: Colors.orange),
        selectedItemColor: const Color(0xFF555555),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedItemColor: Colors.black));
