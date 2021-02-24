import 'package:json_annotation/json_annotation.dart';

part "listing_formdata.g.dart";

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ListingFormData {
  int endDate;
  int commodityId;
  double price;
  int maxAmount;
  double latitude;
  double longitude;
  String additionalInfo;



  factory ListingFormData.fromJson(Map<String, dynamic> json) =>
      _$ListingFormDataFromJson(json);
  Map<String, dynamic> toJson() => _$ListingFormDataToJson(this);

  ListingFormData({this.endDate, this.commodityId, this.price, this.maxAmount,
      this.latitude, this.longitude, this.additionalInfo});
}