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
              //TODO: HANDLE/DESERIALIZE  USER IN ANOTHER PULL REQUEST
              print(user ?? "UNABLE TO PARSE USER");
            });
      } on HttpException catch (e) {
        setState(() {
          _errorMessage = e.message;
          switch (e.message) {
            case "401":
              /// GOT LOGIN ERROR
              _errorMessage = S.of(context).msgErrorLoginRejected;
              break;
            default:
            /// GOT OTHER SERVER ERROR
              _errorMessage = S.of(context).msgErrorServerFail;
              break;
          }
        });
      } on IOException {
        setState(() {
          /// GOT NETWORK/ IO ERROR
          _errorMessage = S.of(context).msgErrorNetworkFail;
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
            Visibility(
              // FIXME: This block currently holds text, but in future
              // FIXME: we can implement a waiting animation or other widget
              child: Center(
                  child: Text(S.of(context).msgAwaitResponse,
                style: TextStyle(
                  fontSize: 18.0,
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
            Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              FlatButton(
                child: Text(
                  S.of(context).loginUser,
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
                  }
                },
              ),
              SizedBox(height: 32.0),
              FlatButton(
                child: Text(S.of(context).createUser,
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                    fontFamily: FontFamily.playfairDisplay,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, routes.UserNew);
                },
              ),
            ]),
          ],
        ));
  }
}
