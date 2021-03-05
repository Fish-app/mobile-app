import 'dart:convert';
import 'dart:core';

import 'package:fishapp/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/seller.dart';
import 'package:fishapp/utils/distance_calculator.dart';

import 'commodity.dart';

part 'listing.g.dart';

String _simplifyComodity(Commodity commodity) {
  return '{"id":${commodity.id}}}';
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Listing {
  num id;
  int created;
  User creator;
  int endDate;

  Commodity commodity;
  double price;
  bool isOpen;

  //Coordinates for pickup location.
  double latitude;
  double longitude;

  Listing(
      {this.id,
      this.created,
      this.creator,
      this.endDate,
      this.commodity,
      this.price,
      this.isOpen,
      this.latitude = 0,
      this.longitude = 0});

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  Map<String, dynamic> toJson() => _$ListingToJson(this);

  Future<double> getDistanceTo() {
    Future<double> dis = calculateDistance(latitude, longitude);
    return dis;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OfferListing extends Listing {
  int maxAmount;
  int amountLeft;

  String additionalInfo;

  OfferListing(
      {num id,
      int dateCreated,
      Seller creator,
      int endDate,
      Commodity commodity,
      double price,
      bool isOpen,
      double latitude,
      double longitude,
      this.maxAmount,
      this.amountLeft,
      this.additionalInfo})
      : super(
            id: id,
            created: dateCreated,
            creator: creator,
            endDate: endDate,
            commodity: commodity,
            price: price,
            isOpen: isOpen,
            latitude: latitude,
            longitude: longitude);

  factory OfferListing.fromJson(Map<String, dynamic> json) =>
      _$OfferListingFromJson(json);

  Map<String, dynamic> toJson() => _$OfferListingToJson(this);

  String toJsonString() => jsonEncode(_$OfferListingToJson(this));
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class BuyRequest extends Listing {
  int amount;
  String additionalInfo;
  double maxDistance;

  BuyRequest(
  {num id,
  int created,
  User creator,
  int endDate,
  Commodity commodity,
  double price,
  bool isOpen,
  double latitude,
  double longitude,
  this.amount,
  this.additionalInfo,
  this.maxDistance})
  : super(
        id: id,
        created: created,
        creator: creator,
        endDate: endDate,
        commodity: commodity,
        price: price,
        isOpen: isOpen,
        latitude: latitude,
        longitude: longitude);

  factory BuyRequest.fromJson(Map<String, dynamic> json) =>
      _$BuyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BuyRequestToJson(this);

  String toJsonString() => jsonEncode(_$BuyRequestToJson(this));
}
