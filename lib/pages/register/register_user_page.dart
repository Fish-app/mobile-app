import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maoyi/config/themes/theme_config.dart';
import 'package:maoyi/widgets/BlurredImage.dart';
import 'package:maoyi/widgets/form_register_user.dart';
import 'package:maoyi/widgets/nav_widgets/common_nav.dart';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage({Key key}) : super(key: key);

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
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
                    RegisterUserForm(),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
