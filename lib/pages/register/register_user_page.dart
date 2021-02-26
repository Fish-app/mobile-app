import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/widgets/BlurredImage.dart';
import 'package:fishapp/pages/register/form_register_user.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';

class RegisterUserPage extends StatefulWidget {
  final LoginReturnRouteData returnRouteData;
  RegisterUserPage({Key key, this.returnRouteData}) : super(key: key);

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
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
                  children: [
                    SizedBox(
                      height: 52.0,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Create User",
                          style: Theme.of(context).primaryTextTheme.headline1,
                        )),
                    RegisterUserForm(returnRoute: widget.returnRouteData),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
