import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:maoyi/entities/commodity.dart';
import 'package:maoyi/entities/seller.dart';
import 'package:maoyi/entities/user.dart';
import 'package:maoyi/utils/distance_calculator.dart';

part 'listing.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Listing {
  num id;
  String dateCreated; // todo: finn ut hvilket dato format vi ender med
  Seller creator;
  String endDate;
  Commodity commodity;
  int price;
  bool isOpen;

  Listing(
      {@required this.id,
      this.dateCreated,
      this.creator,
      this.endDate,
      this.commodity,
      this.price,
      this.isOpen});

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
  Map<String, dynamic> toJson() => _$ListingToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OfferListing extends Listing {
  int maxAmount;
  int amountLeft;
  //Coordinates for pickup.
  double latitude;
  double longitude;

  OfferListing(
      {@required num id,
      String dateCreated,
      Seller creator,
      String endDate,
      Commodity commodity,
      int price,
      bool isOpen,
      @required this.maxAmount,
      @required this.amountLeft,
      @required this.latitude,
      @required this.longitude
      })
      : super(
            id: id,
            dateCreated: dateCreated,
            creator: creator,
            endDate: endDate,
            commodity: commodity,
            price: price,
            isOpen: isOpen);

  Future<double> getDistanceTo() {
    Future<double>  dis = calculateDistance(latitude, longitude);
    return dis;
  }

  factory OfferListing.fromJson(Map<String, dynamic> json) =>
      _$OfferListingFromJson(json);
  Map<String, dynamic> toJson() => _$OfferListingToJson(this);
}
