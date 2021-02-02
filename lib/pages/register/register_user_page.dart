import 'dart:io';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/components/form/register_user_form.dart';

import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/config/routes/router.dart';
import 'package:***REMOVED***/components/input_field.dart';
import 'package:***REMOVED***/components/form/form_validators.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:flutter/rendering.dart';

import 'new_user_form_data.dart';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage({Key key}) : super(key: key);
  final authService = AuthService(***REMOVED***RestClient());

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  //NewUserFormDate _newUserFormDate;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 8.0),
          child: RegisterUserForm(),
        ),
      ),
    );
  }

/*  void _handleRegister() async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (formState.validate()) {
      try {
        await widget.authService.createUser(_newUserFormDate);
        Navigator.pushReplacementNamed(context, routeUserLogin);
      } on HttpException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      }  on CreateUserException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      }
    }
  }*/


}




