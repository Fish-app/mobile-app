import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/utils/auth/jwt.dart';
import 'package:***REMOVED***/utils/services/storage_service.dart';

class AppState extends ChangeNotifier {
  User user;

  JwtTokenData jwtTokenData;

  AppState() {
    _readFromStorage();
  }

  Future<void> _readFromStorage() async {
    var cur_user = await SharedStorage().loadUser();
    var tokenStr = await SecureStorage().readTokenString();

    if (cur_user != null && tokenStr != null) {
      this.user = cur_user;
      this.jwtTokenData = JwtTokenData.buildFromTokenStr(tokenStr);
      notifyListeners();
    }
  }

  bool isLoggedIn() {
    return user != null && jwtTokenData.hasExpired();
  }

  void newAuthValues(String token, User user) {
    jwtTokenData = JwtTokenData.buildFromTokenStr(token);
    this.user = user;
    SecureStorage().writeTokenString(token);
    SharedStorage().saveUser(user);
    notifyListeners();
  }

  void loggOut() {
    SecureStorage().readTokenString();
    SharedStorage().removeUser();
    notifyListeners();
  }
}
