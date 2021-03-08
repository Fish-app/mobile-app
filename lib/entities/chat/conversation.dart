import 'package:fishapp/entities/listing.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user.dart';
import 'message.dart';

part 'conversation.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Conversation {
  num id;
  num lastMessageId;
  num firstMessageId;
  User starterUser;
  Listing listing;

  Conversation({this.id, this.lastMessageId, this.firstMessageId, this.starterUser, this.listing});

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);


  static fromJsonList(List list) {
    if (list == null) return List();
    return list.map((m) => Conversation.fromJson(m)).toList();
  }
}