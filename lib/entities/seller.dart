import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Seller {

  @JsonKey(required: true)
  num id;

  @JsonKey(required: true)
  String name;

  @JsonKey(required: true)
  String email;

  @JsonKey(required: true)
  String regNumber;

  @JsonKey(ignore: true)
  double rating;

  @JsonKey(ignore: true)
  String bankAccountNumber;

  Seller({this.id, this.name, this.email, this.regNumber, this.rating, this.bankAccountNumber});

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);

}