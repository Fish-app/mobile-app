import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {

  @JsonKey(required: true)
  num id;

  @JsonKey(required: true)
  String email;

  @JsonKey(includeIfNull: false)
  double rating;

  String name;

  @JsonKey(name: "created")
  String created;

  User({this.id, this.name, this.email, this.rating, this.created});

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
