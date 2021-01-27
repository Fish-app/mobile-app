import 'dart:convert';
import 'dart:io';

import 'package:maoyi/entities/user.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:maoyi/constants/api_path.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final MaoyiRestClient maoyiRestClient;

  AuthService(this.maoyiRestClient);

  Future<void> createUser
}