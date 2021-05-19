import 'dart:convert';

import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/entities/seller.dart';
import 'package:fishapp/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'listing.dart';

part 'receipt.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Receipt {
  double id;

  double created;

  double amount;

  double price;

  Seller seller;

  User buyer;

  Listing listing;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);

  Receipt(
      {this.id,
      this.created,
      this.amount,
      this.price,
      this.seller,
      this.buyer,
      this.listing});
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class NewOrder {
  int listingId;

  int amount;

  factory NewOrder.fromJson(Map<String, dynamic> json) =>
      _$NewOrderFromJson(json);

  Map<String, dynamic> toJson() => _$NewOrderToJson(this);

  String toJsonString() => jsonEncode(_$NewOrderToJson(this));

  NewOrder({this.listingId, this.amount});
}
