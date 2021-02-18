import 'package:flutter/material.dart';

import 'floating_nav_bar.dart';

AppBar get***REMOVED***TopBar(BuildContext context, String barText) {
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

// this is a shitshow and has to be improved
Scaffold get***REMOVED***DefaultScaffold(BuildContext context,
    {String includeTopBar, NavDestButton useNavBar, Widget child}) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    extendBodyBehindAppBar: true,
    extendBody: true,
    bottomNavigationBar: useNavBar != null
        ? ***REMOVED***NavBar(
            currentActiveButton: useNavBar,
          )
        : null,
    appBar:
        includeTopBar != null ? get***REMOVED***TopBar(context, includeTopBar) : null,
    body: child,
  );
}
