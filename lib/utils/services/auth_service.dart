import 'dart:convert';
import 'dart:io';

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
}