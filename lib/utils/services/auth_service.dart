import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/main.dart';
import 'package:fishapp/pages/login/login_formdata.dart';
import 'package:fishapp/pages/register/new_user_form_data.dart';
import 'package:fishapp/pages/user/user_resetpwd_formdata.dart';
import 'package:fishapp/utils/auth/jwt.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';
import 'package:fishapp/constants/api_path.dart';
import 'package:fishapp/utils/services/storage_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:provider/provider.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final FishappRestClient fishappRestClient = FishappRestClient();

  AuthService();

  Future<void> createUser(
      BuildContext context, NewUserFormData userDetails) async {
    try {
      var response = await fishappRestClient.post(context, createUserEndpoint,
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
    var response = await fishappRestClient.put(context, changePasswordEndpoint,
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
    var response = await fishappRestClient.post(context, loginUserEndpoint,
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
