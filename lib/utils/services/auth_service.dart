import 'dart:convert';
import 'dart:io';

import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/constants/api_path.dart';

class CreateUserException implements Exception {
  String message;
  CreateUserException(this.message);
}

class AuthService {
  final ***REMOVED***RestClient ***REMOVED***RestClient;

  AuthService(this.***REMOVED***RestClient);

  Future<void> createUser
}