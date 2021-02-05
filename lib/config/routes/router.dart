import 'package:maoyi/pages/home/home_page.dart';
import 'package:maoyi/pages/login/login_page.dart';
import 'package:maoyi/pages/chat/chat_page.dart';
import 'package:maoyi/pages/user/user_info.dart';

import '../../main.dart';
import 'package:maoyi/pages/register/register_user_page.dart';

import 'routes.dart' as routes;

import 'package:flutter/material.dart';

Route<dynamic> router(BuildContext context, RouteSettings settings) {
  var path = settings.name;

  Widget page;
  switch (path) {
    case routes.Home:
      page = HomePage();
      break;

    case routes.UserInfo:
      page = UserInfoPage();
      break;
    case routes.UserNew:
      page = RegisterUserPage();
      break;
    case routes.UserLogin:
      page = LoginPage();
      break;
    case routes.chat:
      page = ChatPage();
      break;

    default:
      page = HomePage();
      break;
  }

  return MaterialPageRoute(builder: (context) => page);
}
