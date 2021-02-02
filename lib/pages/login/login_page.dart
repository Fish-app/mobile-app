import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/generated/fonts.gen.dart';
import 'package:maoyi/widgets/formfield_auth.dart';
import 'package:maoyi/widgets/logo.dart';
import 'package:maoyi/widgets/stack_blurredbackground.dart';

//TODO: Discuss if navstack shall be cleared when entering login page ?

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StackBlurredBackground(
        AssetImage('assets/images/background-oceanview.jpg'),
        Container(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: <Widget>[
                SizedBox(
                  height: 52.0,
                ), // Spacing between top and header
                Column(
                  children: [
                    Logo(),
                  ],
                ),
                // Spacing between header and login fields
                SizedBox(height: 148.0),
                FormFieldAuth("email", "hint",
                  validationMsg: "The email is invalid",
                ),
                SizedBox(height: 8.0),
                FormFieldAuth("passord", "safdasd",
                  isObscured: true,
                  validationMsg: "The password is invalid",
                ),
                SizedBox(height: 48.0),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 32.0),
                      ),
                      onPressed: () {
                        //TODO: Implement login call and clear nav stack ?
                      },
                    ),
                    SizedBox(height: 48.0),
                    FlatButton(
                      child: Text(
                        'Create new user',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      onPressed: () {
                        //TODO: Implement new user
                        Navigator.pushNamed(context, routes.RouteAuthLogin);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


