import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  num id;
  String name;
  String username;
  String email;

  User({this.id, this.name, this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Seller extends User {
  String bankAccountNumber;
  String regNumber;

  Seller({num id, String name, String username, String email, this.bankAccountNumber, this.regNumber})
      : super(id: id, name: name, username: username, email: email);

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);
}
