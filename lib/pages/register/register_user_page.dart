import 'dart:io';

import 'package:flutter/material.dart';

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
  RegisterUserPageState createState() => RegisterUserPageState();
}

class RegisterUserPageState extends State<RegisterUserPage> {
  final _formKey = GlobalKey<FormState>();
  NewUserFormDate _newUserFormDate;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _newUserFormDate = NewUserFormDate();
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
            ]
        )
    );
  }
}
