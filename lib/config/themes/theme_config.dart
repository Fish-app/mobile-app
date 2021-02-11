import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///emp- #ffc400
//
// emp-2 #e1ad00
//
// emp knapp -#000000
//
// bakgrunn aktiv bunn meny knapp -#ffffc500
//
// aktiv knapp - #ff262626
//
// stjerne - #ffFFC400
//
// bakgrunn - #fffbfbfb

final emphasisColor = Color(0xffffc400);
final emphasis2Color = Color(0xffe1ad00);
final emphasisButton = Color(0xff000000);
final backgroundActiveMenuButton = Color(0xff262626);
final starColor = Color(0xffFFC400);
final backgroundColor = Color(0xfffbfbfb);

final inputFealdbgColor = Color(0xccffffff);

final softBlack = Color(0xff292929);
final accentGray = Color(0xff1f1f1f);

final ratingStarTheme = IconThemeData(color: starColor, size: 25);

const double appBorderRadius = 20.0;

final TextStyle inputHintStyle = TextStyle(
    fontFamily: "Dosis",
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Colors.black);

final TextStyle inputTextStyle = TextStyle(
    fontFamily: "Dosis",
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.black);

final maoyiLightTheme = ThemeData(
  backgroundColor: Colors.white,

  /// -- Colors -- ///
  primaryColor: Colors.black,
  primaryColorLight: Colors.grey,
  accentColor: Colors.orange,
  focusColor: Colors.orange,

  /// -- Playfair_Display -- ///
  primaryTextTheme: TextTheme(
    headline1: TextStyle(
        fontFamily: "Playfair_Display", color: Colors.black, fontSize: 48),
    headline2: TextStyle(
        fontFamily: "Playfair_Display", color: Colors.white, fontSize: 25),
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
  ),

  /// -- Roboto -- ///
  textTheme: TextTheme(
    headline4:
        TextStyle(fontFamily: "Roboto", color: Colors.black, fontSize: 24),
    headline5: TextStyle(
        fontFamily: "Roboto",
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w400),
    bodyText2: TextStyle(
        fontFamily: "Roboto",
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w300),
    overline: TextStyle(
        fontFamily: "Roboto",
        color: softBlack,
        fontSize: 8,
        fontWeight: FontWeight.w400),
    button: TextStyle(
        fontFamily: "Roboto",
        color: Colors.black,
        letterSpacing: 1.3,
        fontSize: 12,
        fontWeight: FontWeight.w500),
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
  dividerTheme: DividerThemeData(color: Colors.grey, thickness: 0.3),

  /// -- bottom bar -- ///
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      elevation: 10,
      selectedIconTheme: IconThemeData(color: emphasisColor, size: 30),
      selectedItemColor: backgroundActiveMenuButton,
      unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
      unselectedItemColor: Colors.black),

  /// -- Standard Button -- ///
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 25, vertical: 0)),
          backgroundColor: MaterialStateProperty.all<Color>(emphasisColor))),

  /// -- TextFormField -- ///
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 5),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide.none),
    filled: true,
    fillColor: inputFealdbgColor,
    hintStyle: inputHintStyle,
  ),

  /// -- AppBar -- ///
  appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        headline4: TextStyle(
            fontFamily: "Playfair_Display", color: Colors.black, fontSize: 24),
      )),

  scaffoldBackgroundColor: backgroundColor,
);
