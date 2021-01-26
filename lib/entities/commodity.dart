import 'package:json_annotation/json_annotation.dart';
import 'package:***REMOVED***/entities/image.dart';

part 'commodity.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Commodity {
  num id;
  String name;
  Image commodityImage;

  Commodity({this.id, this.name, this.commodityImage});

  factory Commodity.fromJson(Map<String, dynamic> json) => _$CommodityFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityToJson(this);
}
