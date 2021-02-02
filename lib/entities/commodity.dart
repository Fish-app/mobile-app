import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:maoyi/entities/image.dart';

part 'commodity.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Commodity {
  num id;
  String name;
  ImageData commodityImage;

  Commodity({this.id, this.name, this.commodityImage});

  Image getImage() {
    return Image.network(
        "https://images.pexels.com/photos/3640451/pexels-photo-3640451.jpeg");
  }

  factory Commodity.fromJson(Map<String, dynamic> json) =>
      _$CommodityFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityToJson(this);
}
