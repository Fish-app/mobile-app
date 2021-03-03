import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  @JsonKey(required: true)
  num id;

  @JsonKey(required: true)
  String email;

  @JsonKey(ignore: true)
  double rating;

  String name;

  @JsonKey(name: "created")
  String created;

  User({this.id, this.name, this.email, this.rating, this.created});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserLoginData {
  String userName;
  String password;

  factory UserLoginData.fromJson(Map<String, dynamic> json) =>
      _$UserLoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginDataToJson(this);

  UserLoginData({this.userName, this.password});

  String toJsonString() => jsonEncode(_$UserLoginDataToJson(this));
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserNewData extends UserLoginData {
  String name;

  factory UserNewData.fromJson(Map<String, dynamic> json) =>
      _$UserNewDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserNewDataToJson(this);

  UserNewData({userName, password, this.name})
      : super(password: password, userName: userName);

  String toJsonString() => jsonEncode(_$UserNewDataToJson(this));
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserChangePasswordData extends UserLoginData {
  String oldPassword;
  String newPassword;

  factory UserChangePasswordData.fromJson(Map<String, dynamic> json) =>
      _$UserChangePasswordDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserChangePasswordDataToJson(this);

  UserChangePasswordData({userName, password, this.name})
      : super(password: password, userName: userName);

  String toJsonString() => jsonEncode(_$UserChangePasswordDataToJson(this));
}
