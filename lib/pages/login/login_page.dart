import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/generated/fonts.gen.dart';
import 'package:maoyi/widgets/formfield_auth.dart';
import 'package:maoyi/widgets/logo.dart';
import 'package:maoyi/widgets/stack_blurredbackground.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StackBlurredBackground(
        AssetImage('assets/images/background-oceanview.jpg'),
        Container(
          /// Hack on how to float elements with viewport
          /// https://stackoverflow.com/a/65624909
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
                Column(
                  children: [
                    Logo(),
                  ],
                ),
                // Spacing between header and login fields
                SizedBox(height: 148.0),
                FormFieldAuth(
                  title: "E-mail",
                  hint: "someone@example.com",
                  validationMsg: "The email is invalid",
                ),
                SizedBox(height: 8.0),
                FormFieldAuth(
                  title: "Password",
                  hint: "Enter your password here",
                  isObscured: true,
                  validationMsg: "The password is invalid",
                ),
                SizedBox(height: 48.0),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlatButton(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 48.0,
                            color: Colors.white,
                            fontFamily: FontFamily.playfairDisplay,
                        ),
                      ),
                      onPressed: () {
                        //TODO: Implement login
                      },
                    ),
                    SizedBox(height: 32.0),
                    FlatButton(
                      child: Text(
                        'Create new user',
                        style: TextStyle(
                          fontSize: 36.0,
                          color: Colors.white,
                          fontFamily: FontFamily.playfairDisplay,
                        ),
                      ),
                      onPressed: () {
                        //TODO: Implement new user
                        Navigator.pushNamed(context, routes.UserNew);
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
