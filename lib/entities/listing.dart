import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/seller.dart';
import 'package:fishapp/utils/distance_calculator.dart';

part 'listing.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Listing {
  num id;
  int created;
  Seller creator;
  int endDate;
  Commodity commodity;
  double price;
  bool isOpen;

  Listing(
      {this.id,
      this.created,
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

  //Coordinates for pickup location.
  double latitude;
  double longitude;

  String additionalInfo;

  OfferListing(
      {num id,
      int dateCreated,
      Seller creator,
      int endDate,
      Commodity commodity,
      double price,
      bool isOpen,
      this.maxAmount,
      this.amountLeft,
      this.latitude,
      this.longitude,
      this.additionalInfo})
      : super(
            id: id,
            created: dateCreated,
            creator: creator,
            endDate: endDate,
            commodity: commodity,
            price: price,
            isOpen: isOpen);

  Future<double> getDistanceTo() {
    Future<double> dis = calculateDistance(latitude, longitude);
    return dis;
  }

  factory OfferListing.fromJson(Map<String, dynamic> json) =>
      _$OfferListingFromJson(json);

  Map<String, dynamic> toJson() => _$OfferListingToJson(this);

  String toJsonString() => jsonEncode(_$OfferListingToJson(this));
}
