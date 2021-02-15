import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'jwt.g.dart';

@JsonSerializable()
class JwtTokenData {
  @JsonKey(name: "sub")
  String userId;

  // seconds since epoc
  @JsonKey(name: "iat")
  double issuedAt;

  // seconds since epoc
  @JsonKey(name: "exp")
  double expiresAt;

  @JsonKey(name: "upn")
  String userEmail;

  JwtTokenData(
      {this.userId,
      this.issuedAt,
      this.expiresAt,
      this.userEmail,
      this.groups});

  List<String> groups;
  factory JwtTokenData.fromJson(Map<String, dynamic> json) =>
      _$JwtTokenDataFromJson(json);
  Map<String, dynamic> toJson() => _$JwtTokenDataToJson(this);

  @JsonKey(ignore: true)
  String tokenString;

  static JwtTokenData buildFromTokenStr(String token) {
    var jsonMap = _parseJwt(token);
    var tokenData = JwtTokenData.fromJson(jsonMap);
    tokenData.tokenString = token;
    return tokenData;
  }

  bool hasExpired() {
    return expiresAt < DateTime.now().microsecondsSinceEpoch / 1000;
  }
}

Map<String, dynamic> _parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);

  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
