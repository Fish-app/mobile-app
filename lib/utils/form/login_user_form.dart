import 'package:flutter/material.dart';
import 'package:***REMOVED***/widgets/formfield_auth.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/generated/fonts.gen.dart';
import 'package:***REMOVED***/widgets/formfield_auth.dart';

class LoginUserForm extends StatefulWidget {
  @override
  _LoginUserFormState createState() => _LoginUserFormState();
}

class _LoginUserFormState extends State<LoginUserForm> {
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        FormFieldAuth(
          title: "Email",
          hint: "someone@example.com",
          validationMsg: "The email is invalid",
        ),
        FormFieldAuth(
          title: "Password",
          hint: "Enter your password here",
          isObscured: true,
          validationMsg: "The password is invalid",
        ),
        SizedBox(height: 48.0),
        Column(mainAxisSize: MainAxisSize.min, children: [
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
        ]),
      ],
    ));
  }
}
