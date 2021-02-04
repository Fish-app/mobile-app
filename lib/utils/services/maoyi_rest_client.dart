import 'dart:convert';

import 'package:http/http.dart' as http;

class MaoyiRestClient {
  var _client = http.Client();

  Future<Map<String, String>> _addAuthToHeaders(Map<String, String> headers) async {
    final token = null; // TODO: get token here
    headers ??= new Map<String, String>();
    return headers..addAll({"Authorization": token});
  }

  Future<http.Response> get(dynamic url, {Map<String, String> headers, bool addAuth = true}) async {
    return _client.get(url, headers: addAuth ? await _addAuthToHeaders(headers) : headers);
  }

  Future<http.Response> post(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding, bool addAuth = true}) async {
    return _client.post(url, headers: addAuth ? await _addAuthToHeaders(headers) : headers, body: body, encoding: encoding);
  }

  Future<http.Response> put(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding, bool addAuth = true}) async {
    return _client.put(url, headers: addAuth ? await _addAuthToHeaders(headers) : headers, body: body, encoding: encoding);
  }

  Future<http.Response> delete(dynamic url, {Map<String, String> headers, bool addAuth = true}) async {
    return _client.delete(url, headers: addAuth ? await _addAuthToHeaders(headers) : headers);
  }
}
