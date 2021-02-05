import 'dart:io';
import 'package:strings/strings.dart';

import 'package:flutter/material.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/pages/register/new_user_form_data.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:maoyi/widgets/formfield_auth.dart';
import 'package:maoyi/utils/form/form_validators.dart';
import 'package:maoyi/widgets/standard_button.dart';

class RegisterUserForm extends StatefulWidget {
  RegisterUserForm({Key key}) : super(key: key);
  final authService = AuthService(MaoyiRestClient());

  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = false;
  NewUserFormData _newUserFormData;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _newUserFormData = NewUserFormData();
  }

  void _handleRegister() async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (formState.validate()) {
      try {
        await widget.authService.createUser(_newUserFormData);
        Navigator.pushReplacementNamed(context, routes.UserLogin);
      } on CreateUserException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      } on HttpException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      }
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
                title: S.of(context).name,
                hint: S.of(context).fullName,
                keyboardType: TextInputType.name,
                onSaved: (newValue) =>
                {_newUserFormData.name = newValue},
                validator: (value) {
                  return validateNotEmptyInput(value, context);
                },
              ),
              FormFieldAuth(
                title: capitalize(S.of(context).email),
                hint: S.of(context).emailHint,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) =>
                {_newUserFormData.email = newValue},
                validator: (value) {
                  return validateEmail(value, context);
                },
              ),
              FormFieldAuth(
                title: capitalize(S.of(context).password),
                hint: S.of(context).passwordHint,
                keyboardType: TextInputType.text,
                onSaved: (newValue) =>
                {_newUserFormData.password = newValue},
                validator: (value) {
                  return validateLength(value, context, min: 8);
                },
                isObscured: true,
              ),
              FormFieldAuth(
                title: S.of(context).confirmPassword,
                hint: S.of(context).confirmPasswordHint,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return validateEquality(
                      value, _newUserFormData.password, S.of(context).password, context);
                },
                isObscured: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Checkbox(
                        value: _agreedToTOS,
                        onChanged: _setAgreedToTOS
                    ),
                    GestureDetector(
                      onTap: () => _setAgreedToTOS(!_agreedToTOS),
                      child: Text(
                          S.of(context).tos,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  StandardButton(
                    buttonText: S.of(context).createUser.toUpperCase(),
                    onPressed:  _submittable() ? _handleRegister : null,
                  )
                ],
              ),
              Text(
               _errorMessage,
                style: TextStyle(
                  color: Theme.of(context).errorColor
                ),
              )
            ]
        )
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}