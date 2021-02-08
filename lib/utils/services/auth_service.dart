import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:maoyi/entities/user.dart';
import 'package:maoyi/main.dart';
import 'package:maoyi/pages/login/login_formdata.dart';
import 'package:maoyi/pages/register/new_user_form_data.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:maoyi/constants/api_path.dart';
import 'package:maoyi/utils/services/secure_storage.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final MaoyiRestClient maoyiRestClient;
  final SecureStorage secureStorage = SecureStorage();
  AuthService(this.maoyiRestClient);

  Future<void> createUser(NewUserFormData userDetails) async {
    try {
      var response = await maoyiRestClient.post(createUserEndpoint,
          headers: userDetails.toMap());
      if (response.statusCode == 409) {
        throw CreateUserException("Email already exists");
      } else {
        throw HttpException("Error creating user");
      }
    } on IOException {
      throw HttpException("Service unavailable");
    }
  }

  Future<User> doLoginUser(LoginUserFormData loginDetails) async {
    try {
      var response = await maoyiRestClient.post(loginUserEndpoint,
          headers: loginDetails.toMap()).timeout(Duration(seconds: 7));
      switch (response.statusCode) {
        case 200:
          Map decoderOutput = jsonDecode(response.body);
          print("body:" + response.body);
          var user = User.fromJson(decoderOutput);
          print(decoderOutput);
          if (user != null) {
            log('OK GOT-USER');
            String token = response.headers["authorization"];
            secureStorage.writeSecure("token", token);
            return user;
          } else {
            log('OK NO-USER');
            return null;
          }
          break;
        case 401:
          throw HttpException(HttpStatus.unauthorized.toString());
          break;
        case 500:
          throw HttpException(HttpStatus.internalServerError.toString());
          break;
        default:
          /// Should never happen, most possible malformed repsonse
          log("Unknown response");
          return null;
          break;
      }
    } on IOException catch (e) {
      log("IO failure " + e.toString());
      throw e;
    }
  }
}
