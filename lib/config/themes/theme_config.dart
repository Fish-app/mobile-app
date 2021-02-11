import 'package:flutter/material.dart';
import 'package:***REMOVED***/generated/fonts.gen.dart';

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
    headline1: TextStyle(
        fontFamily: "Playfair_Display", color: Colors.black, fontSize: 48),
    headline3: TextStyle(
        fontFamily: "Playfair_Display", color: Colors.black, fontSize: 33),
    headline4: TextStyle(
        fontFamily: "Playfair_Display", color: Colors.black, fontSize: 24),
    headline5: TextStyle(
        fontFamily: "Playfair_Display", color: Colors.black, fontSize: 20),
    headline6: TextStyle(
        fontFamily: "Playfair_Display", color: Colors.black, fontSize: 15),
    bodyText1: TextStyle(
      fontFamily: "Playfair_Display",
      color: Colors.black,
      fontSize: 20,
    ),
    bodyText2: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20,
        color: Colors.black
    ),

  ),

  /// -- CardTheme -- ///
  cardTheme: CardTheme(
    elevation: 10,
    clipBehavior: Clip.hardEdge,
    color: Colors.white,
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
      unselectedItemColor: Colors.black),

  /// -- Standard Button -- ///
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow[600]))),

  /// -- TextFormField -- ///
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(
        fontFamily: "Dosis",
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.black),
  ),

  /// -- AppBar -- ///
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black
    ),
    textTheme: TextTheme(
      headline4: TextStyle(
          fontFamily: "Playfair_Display", color: Colors.black, fontSize: 24),
    )
  ),

  scaffoldBackgroundColor: Colors.white,
);
