import 'dart:convert';
import 'dart:io';

import 'package:maoyi/pages/login/login_formdata.dart';
import 'package:maoyi/pages/register/new_user_form_data.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:maoyi/constants/api_path.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final MaoyiRestClient maoyiRestClient;

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

  Future<void> doLoginUser(LoginUserFormData loginDetails) async {
    try {
      var response = await maoyiRestClient.post(loginUserEndpoint,
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