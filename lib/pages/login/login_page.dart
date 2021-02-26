import 'package:flutter/material.dart';
import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/config/routes/router.dart';
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/widgets/BlurredImage.dart';
import 'package:fishapp/pages/login/form_user_login.dart';
import 'package:fishapp/widgets/logo.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';

class LoginPage extends StatefulWidget {
  final LoginReturnRouteData loginReturnRouteData;
  LoginPage({Key key, this.loginReturnRouteData}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        includeTopBar: "",
        child: Stack(
          children: [
            BlurredImage(
              backgroundImage:
                  AssetImage('assets/images/background-oceanview.jpg'),
              blurColor: softBlack.withOpacity(0.05),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  children: <Widget>[
                    SizedBox(
                      height: 52.0,
                    ), // Spacing between top and header
                    Align(alignment: Alignment.center, child: Logo()),
                    LoginUserForm(
                      returnPath: widget.loginReturnRouteData,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
