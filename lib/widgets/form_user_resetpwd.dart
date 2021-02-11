import 'dart:io';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/pages/user/user_resetpwd_formdata.dart';
import 'package:***REMOVED***/utils/form/form_validators.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/widgets/formfield_auth.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;

class ResetPasswordForm extends StatefulWidget {
  final _buttonColor = Colors.amber;
  final authService = AuthService(***REMOVED***RestClient());

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";

  ResetPasswordFormData _resetPwdFormData;
  String _errorMessage = "";
  bool _displayAwaitHolder = false;

  @override
  void initState() {
    super.initState();
    _resetPwdFormData = ResetPasswordFormData();
    _setUserDetails();
  }

  void _setUserDetails() async {
    User user = await AuthService.isUserLoggedIn();
    if (user != null) {
      setState(() {
        this._email = user.email;
      });
    } else {
      Navigator.of(context).pushNamed(routes.UserLogin);
    }
  }

  void _handlePasswordResetRequest() async {
    //TODO: Handle password reset with formdata & mail + token
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (formState.validate()) {
      try {
        await widget.authService
            .changePassword(_resetPwdFormData)
            .then((value) {
              // LOGOUT USER AND SHOW DIALOG
          AuthService.logout();
          _showPasswordChangedDialog();
        });
      } on HttpException catch (e) {
        setState(() {
          _errorMessage = e.message;
          switch (e.message) {
            case "401":
              _errorMessage =
                  "Fikk ikke til å endre passord, start appen på nytt";
              break;
            case "403":
              _errorMessage = "Sjekk att gammelt passord er korrekt";
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
    }
  }

  Future<void> _showPasswordChangedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Passordet ble endret"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Din forespørsel om å endre passord er utført."),
                Text("Du må nå logge inn på nytt med ditt nye passord."),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(routes.UserLogin,
                          (route) => false);
                },
                child: Text("Ta meg til innloggingssiden")),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(routes.Home,
                          (route) => false);
                },
                child: Text("Senere"))
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormFieldAuth(
              title: S.of(context).oldPasswordLabel,
              hint: S.of(context).oldPasswordHint,
              keyboardType: TextInputType.text,
              isObscured: true,
              onSaved: (oldPassword) => _resetPwdFormData.oldpwd = oldPassword,
              validator: (oldPassword) =>
                  validateLength(oldPassword, context, min: 8),
              labelColor: Colors.black,
            ),
            FormFieldAuth(
              title: S.of(context).newPasswordLabel,
              hint: S.of(context).newPasswordHint,
              keyboardType: TextInputType.text,
              isObscured: true,
              onSaved: (newPassword) => _resetPwdFormData.newpwd = newPassword,
              validator: (newPassword) {
                return validateLength(newPassword, context, min: 8);
              },
              labelColor: Colors.black,
            ),
            FormFieldAuth(
              title: S.of(context).confirmPassword,
              hint: S.of(context).confirmPasswordHint,
              keyboardType: TextInputType.text,
              isObscured: true,
              validator: (confirmPassword) {
                return validateEquality(
                    confirmPassword,
                    _resetPwdFormData.newpwd,
                    S.of(context).newPasswordLabel,
                    context);
              },
              labelColor: Colors.black,
            ),
            SizedBox(height: 12.0),
            Text(this._email), // TODO: REMOVE /TESTING
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    child: Text("Clear form"),
                    color: widget._buttonColor,
                    onPressed: () {
                      _resetPwdFormData.clearData();
                      _formKey.currentState.reset();
                    },
                  ),
                  SizedBox(width: 12.0),
                  RaisedButton(
                    color: widget._buttonColor,
                    child: Text("Reset password"),
                    onPressed: () {
                      _resetPwdFormData.email = this._email;
                      _handlePasswordResetRequest();
                    },
                  ),
                ],
              ),
            ),
            Text(
              _errorMessage,
              style: TextStyle(color: Theme.of(context).errorColor),
            )
          ],
        ),
      ),
    );
  }
}
