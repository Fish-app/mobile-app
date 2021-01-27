// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listing _$ListingFromJson(Map<String, dynamic> json) {
  return Listing(
    id: json['id'] as num,
    dateCreated: json['dateCreated'] as String,
    creator: json['creator'] == null
        ? null
        : User.fromJson(json['creator'] as Map<String, dynamic>),
    endDate: json['endDate'] as String,
    commodity: json['commodity'] == null
        ? null
        : Commodity.fromJson(json['commodity'] as Map<String, dynamic>),
    price: json['price'] as int,
    isOpen: json['isOpen'] as bool,
  );
}

Map<String, dynamic> _$ListingToJson(Listing instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('dateCreated', instance.dateCreated);
  writeNotNull('creator', instance.creator?.toJson());
  writeNotNull('endDate', instance.endDate);
  writeNotNull('commodity', instance.commodity?.toJson());
  writeNotNull('price', instance.price);
  writeNotNull('isOpen', instance.isOpen);
  return val;
}

OfferListing _$OfferListingFromJson(Map<String, dynamic> json) {
  return OfferListing(
    id: json['id'] as num,
    dateCreated: json['dateCreated'] as String,
    creator: json['creator'] == null
        ? null
        : User.fromJson(json['creator'] as Map<String, dynamic>),
    endDate: json['endDate'] as String,
    commodity: json['commodity'] == null
        ? null
        : Commodity.fromJson(json['commodity'] as Map<String, dynamic>),
    price: json['price'] as int,
    isOpen: json['isOpen'] as bool,
    maxAmount: json['maxAmount'] as int,
    amountLeft: json['amountLeft'] as int,
  );
}

Map<String, dynamic> _$OfferListingToJson(OfferListing instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('dateCreated', instance.dateCreated);
  writeNotNull('creator', instance.creator?.toJson());
  writeNotNull('endDate', instance.endDate);
  writeNotNull('commodity', instance.commodity?.toJson());
  writeNotNull('price', instance.price);
  writeNotNull('isOpen', instance.isOpen);
  writeNotNull('maxAmount', instance.maxAmount);
  writeNotNull('amountLeft', instance.amountLeft);
  return val;
}
