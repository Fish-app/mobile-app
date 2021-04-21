import 'package:fishapp/entities/user.dart';
import 'package:fishapp/utils/auth/jwt.dart';
import 'package:fishapp/utils/services/storage_service.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  User user;

  JwtTokenData jwtTokenData;

  /// -- this may be poor form -- ///
  /// Singeltoning a change notifier feels wrong
  AppState._privateConstruct() {
    _readFromStorage();
  }

  static final AppState _instance = AppState._privateConstruct();

  factory AppState() {
    return _instance;
  }

  /// -- this may be poor form -- ///

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

  bool isSeller() {
    return jwtTokenData?.groups?.contains("seller") ?? false;
  }

  void setToken(String token) {
    jwtTokenData = JwtTokenData.buildFromTokenStr(token);
    SecureStorage().writeTokenString(token);
    notifyListeners();
  }

  void setUser(User user) {
    this.user = user;
    SharedStorage().saveUser(user);
    notifyListeners();
  }

  void loggOut() {
    SecureStorage().removeTokenString();
    SharedStorage().removeUser();
    this.user = null;
    this.jwtTokenData = null;
    notifyListeners();
  }
}
