import 'dart:io';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/pages/user/user_resetpwd_formdata.dart';
import 'package:***REMOVED***/utils/form/form_validators.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/widgets/form/formfield_auth.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:strings/strings.dart';

import '../../widgets/form/formfield_plain.dart';

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
              _errorMessage = S.of(context).msgErrorPasswdChgGeneralFailure;
              break;
            case "403":
              _errorMessage =
                  S.of(context).msgErrorPasswdChgVerificationFailure;
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
          return WillPopScope(
            // Prohibit user to pop back when dialog is open
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(capitalize(S.of(context).msgPasswdChangeOk)),
              content: Text(S.of(context).dialogMsgPasswdChangeOk),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          routes.UserLogin, (route) => false);
                    },
                    child: Text(S.of(context).dialogActionGotoLoginPage)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          routes.Home, (route) => false);
                    },
                    child: Text(S.of(context).dialogActionDoLater))
              ],
            ),
          );
        });
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
            FormFieldPlain(
              title: S.of(context).oldPasswordLabel,
              hint: S.of(context).oldPasswordHint,
              keyboardType: TextInputType.text,
              isObscured: true,
              onSaved: (oldPassword) => _resetPwdFormData.oldpwd = oldPassword,
              validator: (oldPassword) =>
                  validateLength(oldPassword, context, min: 8),
              labelColor: Colors.black,
            ),
            FormFieldPlain(
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
            FormFieldPlain(
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
                    child: Text(S.of(context).clearForm),
                    color: widget._buttonColor,
                    onPressed: () {
                      _resetPwdFormData.clearData();
                      _formKey.currentState.reset();
                    },
                  ),
                  SizedBox(width: 12.0),
                  RaisedButton(
                    color: widget._buttonColor,
                    child: Text(S.of(context).resetPassword),
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
