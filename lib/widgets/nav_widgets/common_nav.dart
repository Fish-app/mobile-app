import 'dart:ui';

import 'package:flutter/material.dart';

import 'floating_nav_bar.dart';

AppBar getFishappTopBar(BuildContext context, String barText,
    bool hideReturnArrow, List<Widget> actions) {
  if (hideReturnArrow == null) hideReturnArrow = false;
  return AppBar(
    bottomOpacity: 1,
    leading: hideReturnArrow == true
        ? SizedBox(width: 24.0, height: 24.0) //uniform spacing without button
        : Transform.scale(
            scale: 0.65,
            child: Ink(
                decoration: ShapeDecoration(
                    color: Color(0xaafbfbfb), shape: CircleBorder()),
                child: IconButton(
                  iconSize: 40.0,
                  icon:
                      Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                )),
          ),
    elevation: Theme.of(context).appBarTheme.elevation,
    title: Text(
      barText,
      style: Theme.of(context).textTheme.headline4,
    ),
    backgroundColor: Theme.of(context).appBarTheme.color,
    iconTheme: IconThemeData(color: Colors.black),
    actions: actions,
  );
}

Scaffold getFishappDefaultScaffold(BuildContext context,
    {String includeTopBar,
    NavDestButton useNavBar,
    bool navBarHideReturn,
    List<Widget> navBarActions,
    Widget child,
    List<Widget> bgDecor,
    bool extendBehindAppBar = true,
    bool extendBody = true}) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    extendBodyBehindAppBar: extendBehindAppBar,
    extendBody: extendBody,
    bottomNavigationBar: useNavBar != null
        ? FishappNavBar(
            currentActiveButton: useNavBar,
          )
        : null,
    appBar: includeTopBar != null
        ? getFishappTopBar(
            context, includeTopBar, navBarHideReturn, navBarActions)
        : null,
    body: Stack(
      fit: StackFit.expand,
      children: [if (bgDecor != null) ...bgDecor, child],
    ),
  );
}
