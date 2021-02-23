import 'package:flutter/material.dart';

import 'floating_nav_bar.dart';

AppBar getMaoyiTopBar(BuildContext context, String barText) {
  return AppBar(
    bottomOpacity: 1,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
    elevation: Theme.of(context).appBarTheme.elevation,
    title: Text(
      barText,
      style: Theme.of(context).textTheme.headline4,
    ),
    backgroundColor: Theme.of(context).appBarTheme.color,
    iconTheme: IconThemeData(color: Colors.black),
  );
}

// TODO: this is a shitshow and has to be improved
Scaffold getMaoyiDefaultScaffold(BuildContext context,
    {String includeTopBar, NavDestButton useNavBar,
      Widget child, bool extendBehindAppBar = true, bool extendBody = true}) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    extendBodyBehindAppBar: extendBehindAppBar,
    extendBody: extendBody,
    bottomNavigationBar: useNavBar != null
        ? MaoyiNavBar(
            currentActiveButton: useNavBar,
          )
        : null,
    appBar:
        includeTopBar != null ? getMaoyiTopBar(context, includeTopBar) : null,
    body: child,
  );
}
