import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/components/form/register_user_form.dart';

import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/config/routes/router.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:flutter/rendering.dart';
import 'package:***REMOVED***/widgets/logo.dart';
import 'package:***REMOVED***/widgets/stack_blurredbackground.dart';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage({Key key}) : super(key: key);
  final authService = AuthService(***REMOVED***RestClient());

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  //NewUserFormDate _newUserFormDate;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StackBlurredBackground(
        AssetImage('assets/images/background-oceanview.jpg'),
        Container(
          //Solution for scrolling fields while background is locked
          //Found on https://stackoverflow.com/questions/65622166/background-image-is-moving-when-keyboards-appears-flutter
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: <Widget>[
                SizedBox(
                  height: 52.0,
                ),
                Column(
                  children: [
                    Logo(),
                  ],
                ),
                RegisterUserForm(),
              ],
            ),
          ),
        )
      ),
    );
  }
}




