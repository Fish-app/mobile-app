import 'package:fishapp/entities/listing.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'conversation.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Conversation {
  num id;
  num lastMessageId;
  num firstMessageId;
  Listing listing;

  List<Message> msgsInConversation;

  Conversation({this.id, this.lastMessageId, this.firstMessageId, this.listing});

  addMultipleMsgsInConversation(List<Message> newMsgs) {
    // Add a list of messages to the exsisting message list
    // in the conversations
  }

  addMessageToConversation(Message message) {
    // add a single message to the conversation
    if(this.msgsInConversation == null) new List<Message>();
    this.msgsInConversation.add(message);
  }

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}