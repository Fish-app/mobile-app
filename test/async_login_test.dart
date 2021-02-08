import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:maoyi/constants/api_path.dart';
import 'package:maoyi/entities/user.dart';
import 'package:maoyi/pages/login/login_formdata.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

class MayoiMockClient implements MaoyiRestClient {
  var _client = MockClient();

  Map<String, String> _addAuthToHeaders(Map<String, String> headers) {
    final token = null; // TODO: get token here
    headers ??= new Map<String, String>();
    return headers..addAll({"Authorization": token});
  }

  @override
  Future<http.Response> delete(url, {Map<String, String> headers, bool addAuth = true}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers, bool addAuth = true}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(url, {Map<String, String> headers, body, Encoding encoding, bool addAuth = true}) {
   return _client.post(url, headers: addAuth ? _addAuthToHeaders(headers) : headers);
  }

  @override
  Future<http.Response> put(url, {Map<String, String> headers, body, Encoding encoding, bool addAuth = true}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}

main() {
  group("sendLogin", () {
    test("throws exception if logon is rejected", () async {

      final MaoyiRestClient mockClient = MayoiMockClient();
      final AuthService testAuthService = AuthService(mockClient);
      const Duration timeLimit = Duration(seconds: 4);
      when(mockClient.post(loginUserEndpoint).timeout(timeLimit)).
      thenAnswer(
          (_) async => http.Response("wrong username/password", 401)
      );
      LoginUserFormData testFormData = LoginUserFormData();
      testFormData.email = "wrong@wrong.com";
      testFormData.password = "Wrong1234";
      User user = await testAuthService.doLoginUser(testFormData);
      expect(user,null, reason: "We should get null when user logon fails");

    });
    
    
  });

}
