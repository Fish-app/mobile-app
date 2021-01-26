import 'routes.dart' as routes;

import 'package:flutter/material.dart';

Route<dynamic> router(BuildContext context, RouteSettings settings) {
  var path = settings.name;

  Widget page;
  switch (path) {
    case routes.Home:
      break;

    case routes.UserInfo:
      break;
    case routes.UserNew:
      break;
  }

  return MaterialPageRoute(builder: (context) => page);
}
