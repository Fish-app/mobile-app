import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/generated/fonts.gen.dart';
import 'package:maoyi/pages/register/new_user_form_data.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:maoyi/widgets/formfield_auth.dart';
import 'package:maoyi/utils/form/form_validators.dart';
import 'package:maoyi/config/themes/theme_config.dart';

class RegisterUserForm extends StatefulWidget {
  RegisterUserForm({Key key}) : super(key: key);
  final authService = AuthService(MaoyiRestClient());

  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
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
          //padding: EdgeInsets.symmetric(horizontal: 20.0),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormFieldAuth(
                title: "Full Name",
                hint: "Enter your full name",
                keyboardType: TextInputType.name,
                onSaved: (newValue) =>
                {_newUserFormData.name = newValue},
                validator: (value) {
                  return validateNotEmptyInput(value);
                },
              ),
              FormFieldAuth(
                title: "Email",
                hint: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) =>
                {_newUserFormData.email = newValue},
                validator: (value) {
                  return validateEmail(value);
                },
              ),
              FormFieldAuth(
                title: "Password",
                hint: "Enter your password",
                keyboardType: TextInputType.text,
                onSaved: (newValue) =>
                {_newUserFormData.password = newValue},
                validator: (value) {
                  return validateLength(value, min: 8);
                },
                isObscured: true,
              ),
              FormFieldAuth(
                title: "Confirm Password",
                hint: "Enter your password again",
                keyboardType: TextInputType.text,
                validator: (value) {
                  return validateEquality(
                      value, _newUserFormData.password, "password");
                },
                isObscured: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: _agreedToTOS,
                        onChanged: _setAgreedToTOS
                    ),
                    GestureDetector(
                      onTap: () => _setAgreedToTOS(!_agreedToTOS),
                      child: const Text(
                          'I agree to the Terms of Services and Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  const Spacer(),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)
                      ),
                      onPressed: _submittable() ? _handleRegister : null,
                      child: Text(
                        'CREATE USER',
                        style: Theme.of(context).primaryTextTheme.headline5,
                      )
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