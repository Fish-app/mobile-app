import 'package:fishapp/entities/listing.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Conversation {
  num id;
  num lastMessageId;
  num firstMessageId;
  Listing listing;

  Conversation({this.id, this.lastMessageId, this.firstMessageId, this.listing});


  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}