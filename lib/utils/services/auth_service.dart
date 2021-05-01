import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fishapp/constants/api_path.dart';
import 'package:fishapp/entities/seller.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/api_path.dart';
import '../../entities/user.dart';

class CreateUserException implements Exception {
  String message;

  CreateUserException(this.message);
}

class AuthService {
  final FishappRestClient fishappRestClient = FishappRestClient();

  AuthService();

  Future<void> createUser(UserNewData userNewData) async {
    var uri = getAppUri(CREATE_BUYER_ENDPOINT);
    var response = await fishappRestClient.post(uri,
        contentType: ContentType.json,
        body: userNewData.toJsonString(),
        addAuth: false);

    if (response.statusCode != HttpStatus.ok) {
      ApiException(response).dump();
      throw ApiException(response);
    }
  }

  Future<void> createSeller(SellerNewData sellerNewData) async {
    var uri = getAppUri(CREATE_SELLER_ENDPOINT);
    var response = await fishappRestClient.post(uri,
        contentType: ContentType.json,
        body: sellerNewData.toJsonString(),
        addAuth: false);

    if (response.statusCode != HttpStatus.ok) {
      ApiException(response).dump();
      throw ApiException(response);
    }
  }

  Future<void> changePassword(
      BuildContext context, UserChangePasswordData changePasswordData) async {
    var uri = getAppUri(CHANGE_PASSWORD_ENDPOINT);
    var response = await fishappRestClient.patch(uri,
        contentType: ContentType.json,
        body: changePasswordData.toJsonString(),
        addAuth: true);
    if (response.statusCode == HttpStatus.ok) {
    } else {
      ApiException(response).dump();
      throw ApiException(response);
    }
  }

  Future<bool> loginUser(UserLoginData loginData) async {
    var uri = getAppUri(LOGIN_USER_ENDPOINT);

    var response = await fishappRestClient.post(uri,
        contentType: ContentType.json,
        body: loginData.toJsonString(),
        addAuth: false);
    if (response.statusCode == HttpStatus.ok) {
      User user = User.fromJson(jsonDecode(response.body));
      if (user != null) {
        String token = response.headers["authorization"];
        AppState().newAuthValues(token, user);
        return true;
      }
      return false;
    } else {
      ApiException(response).dump();
      throw ApiException(response);
    }
  }

  static Future<void> logout() async {
    AppState().loggOut();
  }
}
