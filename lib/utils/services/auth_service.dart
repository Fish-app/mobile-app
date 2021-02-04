import 'dart:convert';
import 'dart:io';

import 'package:***REMOVED***/pages/login/login_formdata.dart';
import 'package:***REMOVED***/pages/register/new_user_form_data.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/constants/api_path.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final ***REMOVED***RestClient ***REMOVED***RestClient;

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

  Future<void> doLoginUser(LoginUserFormData loginDetails) async {
    try {
      var response = await ***REMOVED***RestClient.post(loginUserEndpoint,
      headers: loginDetails.toMap());
      switch (response.statusCode) {
        case 200:
          print('Login OK');
          break;
        case 401:
          print('Unauthorized');
          break;
        case 500:
          print('Server error');
          break;
        default:
          print('Unknown response');
          break;
      }
    } on IOException {
      throw HttpException("Network unavailable");
    }
  }

}