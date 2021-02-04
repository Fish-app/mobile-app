import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/utils/form/login_user_form.dart';
import 'package:***REMOVED***/widgets/logo.dart';
import 'package:***REMOVED***/widgets/stack_blurredbackground.dart';

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
                Align(alignment: Alignment.center, child: Logo()),
                LoginUserForm(),
                  ],
                ),
            ),
          ),
        ),
      );
  }
}
