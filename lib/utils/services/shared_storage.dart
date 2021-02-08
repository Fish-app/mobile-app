import 'dart:convert';

import 'package:***REMOVED***/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  final _currentUserKey = "user";


  Future<SharedPreferences> get storage {
    return this._storage;
  }


  Future<bool> saveUser(User user) async {
    SharedPreferences _prefs = await this._storage;
    Map userMap = user.toJson();
    bool saveOK = await _prefs.setString(_currentUserKey, jsonEncode(userMap));
      if (saveOK) {
        print('SHAREDPREFS: OK SAVE USER');
      } else {
        print('SHAREDPREFS: ERROR SAVE USER');
      }
      return saveOK;
  }

  Future<User> loadUser() async {
    SharedPreferences _prefs = await this._storage;
    String storedJsonUser = _prefs.getString(_currentUserKey);
    if (storedJsonUser != null) {
      Map userMap = jsonDecode(storedJsonUser);
      print('SHAREDPREFS: OK LOAD USER');
      return User.fromJson(userMap);
    } else {
      print('SHAREDPREFS: ERROR LOAD USER');
      return null;
    }
  }

  Future<bool> removeUser() async {
    SharedPreferences _prefs = await this._storage;
    print('SHAREDPREFS: REMOVED CURRENT USER');
    return _prefs.remove(_currentUserKey);
  }
}