import 'dart:convert';
import 'dart:io';

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
}