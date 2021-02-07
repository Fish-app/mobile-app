import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/main.dart';
import 'package:***REMOVED***/pages/login/login_formdata.dart';
import 'package:***REMOVED***/pages/register/new_user_form_data.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/constants/api_path.dart';
import 'package:***REMOVED***/utils/services/secure_storage.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final ***REMOVED***RestClient ***REMOVED***RestClient;
  final SecureStorage secureStorage = SecureStorage();
  AuthService(this.***REMOVED***RestClient);

  Future<void> createUser(NewUserFormData userDetails) async {
    try {
      var response = await ***REMOVED***RestClient.post(createUserEndpoint,
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
    User user;
    try {
      var response = await ***REMOVED***RestClient.post(loginUserEndpoint,
          headers: loginDetails.toMap()).timeout(Duration(seconds: 7));
      switch (response.statusCode) {
        case 200:
          var decoderOutput = jsonDecode(response.body);
          user = decoderOutput["data"];
          if (user != null) {
            log('OK GOT-USER');
            //TODO: HANDLE TOKEN IN SEPERASTE PULL REQUEST
            String token = response.headers["authorization"];
            secureStorage.writeSecure(token, token);
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
