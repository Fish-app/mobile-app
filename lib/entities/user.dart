import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  num id;
  String name;
  String email;
  double rating;

  User({this.id, this.name, this.email, this.rating});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Seller extends User {
  String bankAccountNumber;
  String regNumber;

  Seller(
      {num id,
      String name,
      String email,
      double rating,
      this.bankAccountNumber,
      this.regNumber})
      : super(
            id: id,
            name: name,
            email: email,
            rating: rating);

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);
}
