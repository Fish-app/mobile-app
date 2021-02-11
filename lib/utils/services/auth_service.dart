import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/main.dart';
import 'package:***REMOVED***/pages/login/login_formdata.dart';
import 'package:***REMOVED***/pages/register/new_user_form_data.dart';
import 'package:***REMOVED***/pages/user/user_resetpwd_formdata.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/constants/api_path.dart';
import 'package:***REMOVED***/utils/services/secure_storage.dart';
import 'package:***REMOVED***/utils/services/shared_storage.dart';

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
          headers: userDetails.toMap(), addAuth: false);
      if (response.statusCode == 409) {
        throw CreateUserException("Email already exists");
      } else {
        throw HttpException("Error creating user");
      }
    } on IOException catch (e) {
      print(e);
      throw HttpException("Service unavailable");
    }
  }

  Future<void> changePassword(ResetPasswordFormData formData) async {
    try {
      var response = await ***REMOVED***RestClient.put(changePasswordEndpoint,
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
    } on IOException catch (e) {
      log("IO failure " + e.toString());
      throw e;
    }
  }

  Future<User> loginUser(LoginUserFormData loginDetails) async {
    try {
      var response = await ***REMOVED***RestClient
          .post(loginUserEndpoint, headers: loginDetails.toMap())
          .timeout(Duration(seconds: 7));
      switch (response.statusCode) {
        case 200:
          Map decoderOutput = jsonDecode(response.body);
          print("body:" + response.body);
          User user = User.fromJson(decoderOutput);
          print(decoderOutput);
          if (user != null) {
            log('OK GOT-USER');
            String token = response.headers["authorization"];
            return saveUserAndToken(user, token);
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

  /// This function takes a User object and a Authorization token,
  /// and saves the user details to normal storage, while saving the
  /// JWT to an encrypted vault. If the operation successeds, we return
  /// the user, so the App can continue as usual. If a failure occur,
  /// we return null to indicate a failure
  Future<User> saveUserAndToken(User user, String token) async {
    bool userOK = false;
    bool tokenOK = false;
    SharedStorage _prefs = SharedStorage();
    SecureStorage _secureStore = SecureStorage();
    if ((user != null && token != null)) {
      // Verify that we have a token and user to save, if not fail with null
      await _secureStore.writeSecure("token", token);
      userOK = await _prefs.saveUser(user);
      await _secureStore.readSecure("token") != null
          ? tokenOK = true
          : tokenOK = false;
    }
    return (tokenOK == true && userOK == true) ? user : null;
  }

  static Future<User> isUserLoggedIn() async {
    User userOK = await _getUserFromStorage();
    bool tokenOK = await isPersistedTokenValid();
    if (tokenOK == true && userOK != null) {
      print('AUTH: USER LOGGED IN OK');
      return userOK;
    } else {
      logout();
      print('AUTH: USER NOT LOGGED IN');
      return null;
    }
  }

  /// This function returns the JWT token, if present in secure storage
  static Future<String> getTokenFromStorage() async {
    SecureStorage _secureStore = SecureStorage();
    return await _secureStore.readSecure("token");
  }

  static Future<User> _getUserFromStorage() async {
    SharedStorage _prefs = SharedStorage();
    return await _prefs.loadUser();
  }

  static Future<bool> isPersistedTokenValid() async {
    String token = await getTokenFromStorage();
    if (token == null || token.isEmpty) {
      return false;
    } else {
      return !(JwtDecoder.isExpired(token));
    }
  }

  static Future<void> logout() async {
    SecureStorage _vault = SecureStorage();
    SharedStorage _prefs = SharedStorage();
    await _vault.deleteSecure("token");
    await _prefs.removeUser();
    return;
  }

  //TODO: GET SELLER / MA83
  static Future<bool> isUserAlreadySeller() async {
    return false;
  }
}
