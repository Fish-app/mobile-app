import 'package:flutter/material.dart';
import 'package:maoyi/config/routes/route_data.dart';
import 'package:maoyi/config/routes/router.dart';
import 'package:maoyi/config/themes/theme_config.dart';
import 'package:maoyi/widgets/BlurredImage.dart';
import 'package:maoyi/pages/login/form_user_login.dart';
import 'package:maoyi/widgets/logo.dart';
import 'package:maoyi/widgets/nav_widgets/common_nav.dart';

class LoginPage extends StatefulWidget {
  final LoginReturnRouteData loginReturnRouteData;
  LoginPage({Key key, this.loginReturnRouteData}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return getMaoyiDefaultScaffold(context,
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
                // todo: if possible remove list view
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
