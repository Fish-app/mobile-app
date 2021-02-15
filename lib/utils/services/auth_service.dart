import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/main.dart';
import 'package:***REMOVED***/pages/login/login_formdata.dart';
import 'package:***REMOVED***/pages/register/new_user_form_data.dart';
import 'package:***REMOVED***/pages/user/user_resetpwd_formdata.dart';
import 'package:***REMOVED***/utils/auth/jwt.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/constants/api_path.dart';
import 'package:***REMOVED***/utils/services/storage_service.dart';
import 'package:***REMOVED***/utils/state/appstate.dart';
import 'package:provider/provider.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final ***REMOVED***RestClient ***REMOVED***RestClient = ***REMOVED***RestClient();

  AuthService();

  Future<void> createUser(
      BuildContext context, NewUserFormData userDetails) async {
    try {
      var response = await ***REMOVED***RestClient.post(context, createUserEndpoint,
          headers: userDetails.toMap(), addAuth: false);
      switch (response.statusCode) {
        case 200:
          break;
        case 409:
          throw CreateUserException("Email already exists");
          break;
        case 500:
        default:
          throw HttpException(HttpStatus.internalServerError.toString());
          break;
      }
    } on IOException catch (e) {
      log("IO failure " + e.toString(), time: DateTime.now());
      throw HttpException("Service unavailable");
    }
  }

  Future<void> changePassword(
      BuildContext context, ResetPasswordFormData formData) async {
    var response = await ***REMOVED***RestClient.put(context, changePasswordEndpoint,
        headers: formData.toMap(), addAuth: true);
    switch (response.statusCode) {
      case 200:
        break;
      case 401:
        throw HttpException(HttpStatus.unauthorized.toString());
        break;
      case 403:
        throw HttpException(HttpStatus.forbidden.toString());
      case 500:
      default:
        throw HttpException(HttpStatus.internalServerError.toString());
        break;
    }
  }

  Future<bool> loginUser(
      BuildContext context, LoginUserFormData loginDetails) async {
    var response = await ***REMOVED***RestClient.post(context, loginUserEndpoint,
        headers: loginDetails.toMap(), addAuth: false);
    switch (response.statusCode) {
      case 200:
        User user = User.fromJson(jsonDecode(response.body));
        if (user != null) {
          String token = response.headers["authorization"];
          Provider.of<AppState>(context, listen: false)
              .newAuthValues(token, user);
          return true;
        }
        break;
      case 401:
        throw HttpException(HttpStatus.unauthorized.toString());
        break;
      case 500:
        throw HttpException(HttpStatus.internalServerError.toString());
        break;
      default:
        break;
    }
    return false;
  }

  static Future<void> logout(BuildContext context) async {
    Provider.of<AppState>(context, listen: false).loggOut();
  }
}
