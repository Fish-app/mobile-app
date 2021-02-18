import 'package:maoyi/config/routes/route_data.dart';
import 'package:maoyi/pages/listing/listing_info_page.dart';
import 'package:maoyi/pages/listing/new_listing_page.dart';
import 'package:maoyi/pages/home/home_page.dart';
import 'package:maoyi/pages/login/login_page.dart';
import 'package:maoyi/pages/chat/chat_page.dart';
import 'package:maoyi/pages/user/user_resetpwd_page.dart';
import 'package:maoyi/pages/user/user_info.dart';
import 'package:maoyi/utils/state/appstate.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'package:maoyi/pages/register/register_user_page.dart';

import 'routes.dart' as routes;

import 'package:flutter/material.dart';

Route<dynamic> router(BuildContext context, RouteSettings settings) {
  var path = settings.name;
  var params = settings.arguments;

  Widget page;

  bool loggedIn = Provider.of<AppState>(context).isLoggedIn();

  Function reqireLogin = (Function route) {
    if (loggedIn) {
      return route();
    } else {
      return LoginPage(
          loginReturnRouteData: LoginReturnRouteData(path, params));
    }
  };

  switch (path) {
    case routes.Home:
      page = HomePage();
      break;

    case routes.UserNew:
      page = RegisterUserPage(
        returnRouteData: params,
      );
      break;
    case routes.UserLogin:
      page = LoginPage(
        loginReturnRouteData: params,
      );
      break;
    case routes.ListingInfo:
      if (params is GenericRouteData) {
        page = ListingInfoPage(
          routeData: params,
        );
      }
      break;
    case routes.NewListing:
      page = NewListingPage();
      break;

    ///  --  Needs login below  -- ///
    case routes.UserInfo:
      page = reqireLogin(() {
        return UserPage();
      });
      break;
    case routes.UserResetPwd:
      page = reqireLogin(() {
        return ChangePasswordPage();
      });
      break;
    case routes.chat:
      page = reqireLogin(() {
        return ChatPage();
      });
      break;
    // case routes.NewListing:
    //   page = reqireLogin(() {
    //     return NewListingPage();
    //   });
    //   break;

    default:
      page = Path404Page();
      break;
  }

  return MaterialPageRoute(builder: (context) => page);
}

class Path404Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("ERROR SIDE NOT FOUND"
          "/side note burde kansje ha en vei ut av skjermen her"),
    );
  }
}
