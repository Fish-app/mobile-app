import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/utils/form/form_validators.dart';
import 'package:fishapp/utils/services/auth_service.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';
import 'package:fishapp/widgets/form/formfield_auth.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:strings/strings.dart';

import '../../entities/user.dart';
import '../../entities/user.dart';
import '../../widgets/form/formfield_plain.dart';

class ResetPasswordForm extends StatefulWidget {
  final _buttonColor = Colors.amber;
  final authService = AuthService();

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";

  UserChangePasswordData _resetPwdFormData = UserChangePasswordData();
  String _errorMessage = "";
  bool _displayAwaitHolder = false;

  void _handlePasswordResetRequest(BuildContext context) async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (formState.validate()) {
      try {
        await widget.authService
            .changePassword(context, _resetPwdFormData)
            .then((value) {
          // LOGOUT USER AND SHOW DIALOG
          AuthService.logout(context);
          _showPasswordChangedDialog();
        });
      } on ApiException catch (e) {
        setState(() {
          switch (e.statusCode) {
            case HttpStatus.unauthorized:
              _errorMessage = S.of(context).msgErrorPasswdChgGeneralFailure;
              break;
            case HttpStatus.forbidden:
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
              onSaved: (oldPassword) =>
                  _resetPwdFormData.oldPassword = oldPassword,
              validator: (oldPassword) =>
                  validateLength(oldPassword, context, min: 8),
              labelColor: Colors.black,
            ),
            FormFieldPlain(
              title: S.of(context).newPasswordLabel,
              hint: S.of(context).newPasswordHint,
              keyboardType: TextInputType.text,
              isObscured: true,
              onSaved: (newPassword) =>
                  _resetPwdFormData.newPassword = newPassword,
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
                    _resetPwdFormData.newPassword,
                    S.of(context).newPasswordLabel,
                    context);
              },
              labelColor: Colors.black,
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    child: Text(S.of(context).clearForm),
                    color: widget._buttonColor,
                    onPressed: () {
                      _resetPwdFormData = UserChangePasswordData();
                      _formKey.currentState.reset();
                    },
                  ),
                  SizedBox(width: 12.0),
                  RaisedButton(
                    color: widget._buttonColor,
                    child: Text(S.of(context).resetPassword),
                    onPressed: () {
                      _handlePasswordResetRequest(context);
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
