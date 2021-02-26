import 'dart:io';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/routes/route_data.dart';
import 'package:***REMOVED***/config/routes/router.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/pages/login/login_formdata.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/widgets/form/formfield_auth.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/utils/form/form_validators.dart';

import 'package:strings/strings.dart';

class LoginUserForm extends StatefulWidget {
  LoginUserForm({Key key, this.returnPath}) : super(key: key);
  final authService = AuthService();
  final LoginReturnRouteData returnPath;

  @override
  _LoginUserFormState createState() => _LoginUserFormState();
}

class _LoginUserFormState extends State<LoginUserForm> {
  final _formKey = GlobalKey<FormState>();
  LoginUserFormData _loginUserFormData = LoginUserFormData();
  String _errorMessage = "";
  bool _displayAwaitHolder = false;

  /// This function ask auth_service to do a login request,
  /// if successful we navigate to the home page. If failure occur,
  /// it is handled and displayed in a friendly manner to the user
  void _handleLoginRequest(BuildContext context) async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
      _displayAwaitHolder = true;
    });

    formState.save();
    if (formState.validate()) {
      try {
        var sucsess =
            await widget.authService.loginUser(context, _loginUserFormData);
        if (sucsess) {
          // LOGIN OK
          Navigator.popAndPushNamed(
              context, widget.returnPath?.path ?? routes.Home,
              arguments: widget.returnPath?.pathParams);
        } else {
          // TODO: Når kan det her egentlig skje, vil det ikke ver en fuckup på serveren i såfall

          // JSON ERROR HANDELING
          print("FORMLOGIN: PARSE ERROR");
          setState(() {
            _errorMessage = S.of(context).msgErrorClientSerializationFail;
          });
        }
      } on HttpException catch (e) {
        // SERVER ERROR CODE HANDELING
        setState(() {
          _errorMessage = e.message;
          switch (e.message) {
            case "401":
              _errorMessage = S.of(context).msgErrorLoginRejected;
              break;
            default:
              _errorMessage = S.of(context).msgErrorServerFail;
              break;
          }
        });
      } on IOException {
        // SOCKET/IO TRANSPORT ERROR HANDELING
        setState(() {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormFieldAuth(
                initialValue: "oluf@example.com",
                title: capitalize(S.of(context).email),
                hint: S.of(context).emailHint,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => {_loginUserFormData.email = newValue},
                validator: (value) {
                  return validateEmail(value, context);
                },
              ),
              FormFieldAuth(
                initialValue: "Passord123",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    /// LOADING PLACEHOLDER TODO: IN future add loading anim
                    Visibility(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(S.of(context).msgAwaitResponse,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline4
                                  .copyWith(
                                    color: Colors.white,
                                  ))),
                      visible: _displayAwaitHolder,
                    ),

                    /// ERROR MESSAGE
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.red,
                          ),
                    ),

                    /// BUTTONS
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      FlatButton(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 130),
                        child: Text(
                          S.of(context).loginUser,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline3
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                        onPressed: () {
                          /// Validate form, if OK send await
                          if (_formKey.currentState.validate()) {
                            _handleLoginRequest(context);
                          }
                        },
                      ),
                      FlatButton(
                        child: Text(
                          S.of(context).createUser,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline4
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, routes.UserNew,
                              arguments: widget.returnPath);
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
