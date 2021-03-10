import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fishapp/entities/seller.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/main.dart';
import 'package:fishapp/utils/auth/jwt.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';
import 'package:fishapp/constants/api_path.dart';
import 'package:fishapp/utils/services/storage_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/api_path.dart';
import '../../constants/api_path.dart';
import '../../constants/api_path.dart';
import '../../entities/user.dart';
import '../../entities/user.dart';
import '../../entities/user.dart';

class CreateUserException implements Exception {
  String message;

  CreateUserException(this.message);
}

class AuthService {
  final FishappRestClient fishappRestClient = FishappRestClient();

  AuthService();

  Future<void> createUser(BuildContext context, UserNewData userNewData) async {
    var uri = getAppUri(createBuyerEndpoint);
    var response = await fishappRestClient.post(context, uri,
        headers: {'Content-type': "application/json"},
        body: userNewData.toJsonString(),
        addAuth: false);

    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw ApiException(response);
    }
  }

  Future<void> createSeller(BuildContext context, SellerNewData sellerNewData) async {
    var uri = getAppUri(createSellerEndpoint);
    try {
      var response = await fishappRestClient.post(context, uri,
          headers: {'Content-type': "application/json"},
          body: sellerNewData.toJsonString(),
          addAuth: false);

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
      BuildContext context, UserChangePasswordData changePasswordData) async {
    var uri = getAppUri(changePasswordEndpoint);
    var response = await fishappRestClient.put(context, uri,
        headers: {'Content-type': "application/json"},
        body: changePasswordData.toJsonString(),
        addAuth: true);
    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw ApiException(response);
    }
  }

  Future<bool> loginUser(BuildContext context, UserLoginData loginData) async {
    var uri = getAppUri(loginUserEndpoint);

    var response = await fishappRestClient.post(context, uri,
        headers: {'Content-type': "application/json"},
        body: loginData.toJsonString(),
        addAuth: false);
    if (response.statusCode == HttpStatus.ok) {
      User user = User.fromJson(jsonDecode(response.body));
      if (user != null) {
        String token = response.headers["authorization"];
        Provider.of<AppState>(context, listen: false)
            .newAuthValues(token, user);
        return true;
      }
      return false;
    } else {
      throw ApiException(response);
    }
  }

  static Future<void> logout(BuildContext context) async {
    Provider.of<AppState>(context, listen: false).loggOut();
  }
}
