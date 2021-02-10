import 'package:flutter/material.dart';
import 'package:maoyi/entities/user.dart';
import 'package:maoyi/pages/user/user_formdatapwd.dart';
import 'package:maoyi/utils/form/form_validators.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/widgets/formfield_auth.dart';
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/widgets/standard_button.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _token = "";
  String _email = "";

  ResetPasswordFormData _resetPasswordFormData;
  String _errorMesg = "";
  bool _displayAwaitHolder = false;

  @override
  void initState() {
    super.initState();
    _resetPasswordFormData = ResetPasswordFormData();
    _setUserDetails();
  }

  void _setUserDetails() async {
    User user = await AuthService.isUserLoggedIn();
    String token = await AuthService.getTokenFromStorage();
    if (user == null || token == null) {
      Navigator.of(context).pushNamed(routes.UserLogin);
    } else {
      setState(() {
        this._email = user.email;
        this._token = token;
      });
    }
  }

  void _handlePasswordResetRequest() async {
    //TODO: Handle password reset with formdata & mail + token
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
              onSaved: (oldPassword) =>
                  _resetPasswordFormData.oldpwd = oldPassword,
              validator: (oldPassword) =>
                  validateLength(oldPassword, context, min: 8),
              labelColor: Colors.black,
            ),
            FormFieldAuth(
              title: S.of(context).newPasswordLabel,
              hint: S.of(context).newPasswordHint,
              keyboardType: TextInputType.text,
              isObscured: true,
              onSaved: (newPassword) =>
                  _resetPasswordFormData.newpwd = newPassword,
              validator: (newPassword) => validateLength(newPassword, context, min: 8),
              labelColor: Colors.black,
            ),
            FormFieldAuth(
              title: S.of(context).confirmPassword,
              hint: S.of(context).confirmPasswordHint,
              keyboardType: TextInputType.text,
              isObscured: true,
              validator: (confirmPassword) => validateEquality(
                  _resetPasswordFormData.newpwd,
                  confirmPassword,
                  S.of(context).newPasswordLabel,
                  context),
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
                    onPressed: () {
                      _resetPasswordFormData.clearData();
                      setState(() {
                        //FIXME: doent work
                      });
                    },
                  ),
                  SizedBox(width: 12.0),
                  RaisedButton(
                    child: Text("Reset password"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _handlePasswordResetRequest();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
