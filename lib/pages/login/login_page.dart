import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/generated/fonts.gen.dart';
import 'package:***REMOVED***/widgets/formfield_auth.dart';
import 'package:***REMOVED***/widgets/logo.dart';
import 'package:***REMOVED***/widgets/stack_blurredbackground.dart';

//TODO: Discuss if navstack shall be cleared when entering login page ?

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlurredBackgroundWidget(
        backgroundImage: AssetImage('assets/images/background-oceanview.jpg'),
        container: Container(
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
                      onPressed: () {},
                      child: Text('Login',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline3
                              .copyWith(color: Colors.white)),
                    ),
                    FlatButton(
                      padding: const EdgeInsets.only(top: 48),
                      child: Text(
                        'Create new user',
                        style: TextStyle(fontSize: 24.0),
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
