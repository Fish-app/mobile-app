import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class NewSubscription {
  String hostedPaymentPageUrl;

  NewSubscription({this.hostedPaymentPageUrl});

  factory NewSubscription.fromJson(Map<String, dynamic> json) =>
      _$NewSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$NewSubscriptionToJson(this);
}
