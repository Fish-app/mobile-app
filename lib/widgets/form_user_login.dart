import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/pages/login/login_formdata.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:maoyi/widgets/formfield_auth.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/generated/fonts.gen.dart';
import 'package:maoyi/utils/form/form_validators.dart';

import 'package:strings/strings.dart';

class LoginUserForm extends StatefulWidget {
  LoginUserForm({Key key}) : super(key: key);
  final authService = AuthService(MaoyiRestClient());

  @override
  _LoginUserFormState createState() => _LoginUserFormState();
}

class _LoginUserFormState extends State<LoginUserForm> {
  final _formKey = GlobalKey<FormState>();
  LoginUserFormData _loginUserFormData;
  String _errorMessage = "";
  bool _displayAwaitHolder = false;

  @override
  void initState() {
    super.initState();
    _loginUserFormData = LoginUserFormData();
  }

  void _handleLoginRequest() async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
      _displayAwaitHolder = true;
    });
    formState.save();
    if (formState.validate()) {
      try {
        await widget.authService
            .doLoginUser(_loginUserFormData)
            .then((user) {
              print(user ?? "UNABLE TO PARSE USER");
            });
      } on HttpException catch (e) {
        setState(() {
          _errorMessage = e.message;
          switch (e.message) {
            case "401":
              _errorMessage = "Unauthorized";
              break;
            default:
              _errorMessage = "Server error";
              break;
          }
        });
      } on IOException {
        setState(() {
          _errorMessage = "Network error";
        });
      }

      /// Disable wait holder on response
      setState(() {
        _displayAwaitHolder = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormFieldAuth(
              title: capitalize(S.of(context).email),
              hint: S.of(context).emailHint,
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => {_loginUserFormData.email = newValue},
              validator: (value) {
                return validateEmail(value, context);
              },
            ),
            FormFieldAuth(
              title: capitalize(S.of(context).password),
              hint: capitalize(S.of(context).passwordHint),
              isObscured: true,
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) {
                _loginUserFormData.password = newValue;
              },
              validator: (value) {
                return validateNotEmptyInput(value, context);
              },
            ),
            SizedBox(height: 48.0),
            Visibility(
              child: Center(
                  child: Text(
                "Please wait",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontFamily: FontFamily.playfairDisplay,
                ),
              )),
              visible: _displayAwaitHolder,
            ),
            Text(
              _errorMessage,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
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
                  /// Validate form, if OK send await
                  if (_formKey.currentState.validate()) {
                    _handleLoginRequest();
                  } else {
                    print('INVALID FORMES');
                  }
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
