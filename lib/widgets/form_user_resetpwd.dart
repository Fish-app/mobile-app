import 'package:flutter/material.dart';
import 'package:***REMOVED***/pages/user/user_formdatapwd.dart';
import 'package:***REMOVED***/utils/form/form_validators.dart';
import 'package:***REMOVED***/widgets/formfield_auth.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/widgets/standard_button.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  ResetPasswordFormData _resetPasswordFormData;
  String _errorMesg = "";
  bool _displayAwaitHolder = false;

  @override
  void initState() {
    super.initState();
    _resetPasswordFormData = ResetPasswordFormData();
  }

  void _handlePasswordResetRequest() async {

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
              validator: (newPassword) => validateLength(newPassword, context),
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
          Row(
            children: [
              StandardButton(
                buttonText: "Clear form",
                onPressed: () {
                  _resetPasswordFormData.clearData();
                  setState(() {
                    //FIXME: doent work
                  });
                },
              ),

              StandardButton(
                buttonText: "Reset password",
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _handlePasswordResetRequest();
                  }
                },
              ),

            ],
          )

        ],
      ),
    );
  }
}
