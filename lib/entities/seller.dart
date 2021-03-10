import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'seller.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Seller extends User {
  @JsonKey(required: true)
  String regNumber;

  @JsonKey(ignore: true)
  String bankAccountNumber;

  Seller(
      {id,
      name,
      email,
      this.regNumber,
      rating,
      this.bankAccountNumber,
      created})
      : super(
            id: id, name: name, rating: rating, email: email, created: created);

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);

  Map<String, dynamic> toJson() => _$SellerToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SellerNewData extends UserLoginData {
  String name;
  String regNumber;

  factory SellerNewData.fromJson(Map<String, dynamic> json) =>
      _$SellerNewDataFromJson(json);

  Map<String, dynamic> toJson() => _$SellerNewDataToJson(this);

  SellerNewData({userName, password, this.name, this.regNumber})
      : super(password: password, userName: userName);

  String toJsonString() => jsonEncode(_$SellerNewDataToJson(this));
}
