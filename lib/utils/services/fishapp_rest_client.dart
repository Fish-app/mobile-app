import 'dart:convert';
import 'dart:io';

import 'package:fishapp/utils/state/appstate.dart';
import 'package:http/http.dart' as http;

///
///  This class prints URL and HTTP Status Codes
///  if an error occurs during networking.
///
class ApiException implements Exception {
  final http.Response response;

  get statusCode => response.statusCode;

  ApiException(this.response);

  //TODO: burde ikke dette logges?
  void dump() {
    print("############## API EXEP ##############");
    print("URL ${this.response.request.url}");
    print("URL ${this.response.statusCode}");
    print("## body ##");
    print(this.response.body);

    print("############## EXEP END ##############");
  }
}

///
/// This class implements a REST Client, used
/// by the various *_service.dart classes
///
class FishappRestClient {
  var _client = http.Client();

  Future<Map<String, String>> _addAuthToHeaders(
      Map<String, String> headers) async {
    //todo: kan bli null fikse senere
    final token = AppState().jwtTokenData?.tokenString;
    headers ??= new Map<String, String>();
    return headers..addAll({"Authorization": token});
  }

  Map<String, String> _addContentType(
      Map<String, String> headers, ContentType contentType) {
    headers ??= new Map<String, String>();
    return headers
      ..addAll({
        'Content-type':
            "${contentType.mimeType}; charset=${contentType.charset}"
      });
  }

  Future<http.Response> get(dynamic url,
      {Map<String, String> headers,
      bool addAuth = true,
      ContentType contentType}) async {
    headers =
        contentType != null ? _addContentType(headers, contentType) : headers;
    headers = addAuth ? await _addAuthToHeaders(headers) : headers;
    return _client.get(url, headers: headers);
  }

  Future<http.Response> post(dynamic url,
      {Map<String, String> headers,
      dynamic body,
      Encoding encoding,
      bool addAuth = true,
      ContentType contentType}) async {
    headers =
        contentType != null ? _addContentType(headers, contentType) : headers;
    headers = addAuth ? await _addAuthToHeaders(headers) : headers;
    return _client.post(url, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> patch(dynamic url,
      {Map<String, String> headers,
      dynamic body,
      Encoding encoding,
      bool addAuth = true,
      ContentType contentType}) async {
    headers =
        contentType != null ? _addContentType(headers, contentType) : headers;
    headers = addAuth ? await _addAuthToHeaders(headers) : headers;
    return _client.patch(url, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> delete(dynamic url,
      {Map<String, String> headers,
      bool addAuth = true,
      ContentType contentType}) async {
    headers =
        contentType != null ? _addContentType(headers, contentType) : headers;
    headers = addAuth ? await _addAuthToHeaders(headers) : headers;
    return _client.delete(url, headers: headers);
  }
}
