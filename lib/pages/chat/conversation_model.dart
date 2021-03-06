import 'dart:collection';

import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/entities/chat/messagebody.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:flutter/widgets.dart';

class ConversationModel extends ChangeNotifier {
  final _buildContext;
  final _conversationService = ConversationService();
  final List<Message> _messages = List();
  final _currentConversation;

  ConversationModel(this._buildContext, this._currentConversation);

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);

  Conversation get conversation => (this._currentConversation);

  void initMessages(List<Message> messages) {
    this._messages.clear();
    this._messages.addAll(messages);
  }

  void initConversation(Conversation conversation) {
    //this._currentConversation = conversation;
  }


  void clear() {
    this._messages.clear();
  }

  Future<void> reloadMessages() async {
    List<Message> reloadResult = List();
    reloadResult = await _conversationService.getMessageUpdates(this._buildContext, this._currentConversation.id, null);
    if(reloadResult.isNotEmpty) {
      this._messages.clear();
      this._messages.addAll(reloadResult);
      notifyListeners();
    }
  }

  Future<void> sendMessage(MessageBody message) async {

    Conversation result =
        await _conversationService.sendMessageRequest(
        this._buildContext, this._currentConversation.id, message);
    if(result != null) {
      reloadMessages();
    }
  }
}