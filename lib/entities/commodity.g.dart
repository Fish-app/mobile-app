// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commodity _$CommodityFromJson(Map<String, dynamic> json) {
  return Commodity(
    id: json['id'] as num,
    name: json['name'] as String,
    commodityImage: json['commodityImage'] == null
        ? null
        : Image.fromJson(json['commodityImage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommodityToJson(Commodity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('commodityImage', instance.commodityImage?.toJson());
  return val;
}
