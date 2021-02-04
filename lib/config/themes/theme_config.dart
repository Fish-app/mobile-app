import 'package:flutter/material.dart';
import 'package:maoyi/generated/fonts.gen.dart';

final themeStarColor = Colors.yellow;

final ratingStarTheme = IconThemeData(color: Colors.orangeAccent, size: 25);

const double appBorderRadius = 20.0;

final maoyiLightTheme = ThemeData(
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
        unselectedItemColor: Colors.black),

    /// -- Standard Button -- ///
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange))),

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

      ///-- Accent Text Theme (on-non-white) --///
      accentTextTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 48.0,
          color: Colors.white,
          fontFamily: FontFamily.playfairDisplay,
        ),
        headline2: TextStyle(
          fontSize: 36.0,
          color: Colors.white,
          fontFamily: FontFamily.playfairDisplay,
        ),

        // Normal white text on accent body
        bodyText1: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: FontFamily.playfairDisplay,
        ),

        // Alternate red body text on accent body
        bodyText2: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.amberAccent,
          fontFamily: FontFamily.playfairDisplay,
        ),
      ),
    );
