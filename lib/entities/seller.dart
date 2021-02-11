import 'package:json_annotation/json_annotation.dart';
import 'package:***REMOVED***/entities/user.dart';

part 'seller.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Seller {

  @JsonKey(required: true)
  num id;


  @JsonKey(required: true)
  User user;

  @JsonKey(required: true)
  String regNumber;

  @JsonKey(ignore: true)
  double rating;

  @JsonKey(ignore: true)
  String bankAccountNumber;

  Seller({this.id, this.user, this.regNumber, this.rating, this.bankAccountNumber});

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);


  static bool isUserSeller(User user, Seller seller) {
    return (user.id == seller.user.id) ? true : false;
  }
}