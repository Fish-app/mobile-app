import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maoyi/components/form/register_user_form.dart';

import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/config/routes/router.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:flutter/rendering.dart';
import 'package:maoyi/widgets/logo.dart';

import 'new_user_form_data.dart';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage({Key key}) : super(key: key);
  final authService = AuthService(MaoyiRestClient());

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  //NewUserFormDate _newUserFormDate;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
        ],
      ),
      /*body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 8.0),
          child: RegisterUserForm(),
        ),
      ),*/
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




