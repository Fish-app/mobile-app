import 'package:maoyi/pages/register/register_user_page.dart';

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
      page = RegisterUserPage();
      break;
  }

  return MaterialPageRoute(builder: (context) => page);
}
