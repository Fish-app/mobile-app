import 'package:json_annotation/json_annotation.dart';
import 'package:***REMOVED***/entities/user.dart';

part 'seller.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Seller {

  @JsonKey(required: true)
  num id;

  @JsonKey(required: true)
  String regNumber;

  @JsonKey(required: true)
  User user;

  Seller({this.id, this.regNumber});

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);

}