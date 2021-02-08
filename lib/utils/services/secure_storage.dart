import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  final _secureStorage = FlutterSecureStorage();

  Future <void>writeSecure(String key, String value) async {
    var write = await _secureStorage.write(key: key, value: value).then(
            (value) => log("SECURE-WRITE:OK")
    );
    return write;
  }

  Future <String>readSecure(String key) async {
    var read = await _secureStorage.read(key: key);
    log("SECURE-READ:" + (read  != null ? "OK" : "NOT FOUND"));
        return read;
  }

  Future <void>deleteSecure(String key) async {
   var delete = await _secureStorage.delete(key: key).then(
           (value) => log("SECURE-DELETE:OK")
   );
   return delete;
  }


  Future <void>clearAllSecure() async {
    var cleared = _secureStorage.deleteAll().then(
        (value) => log("SECURE-CLEAR:OK")
    );
    return cleared;
  }
}