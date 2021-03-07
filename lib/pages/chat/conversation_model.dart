import 'dart:collection';

import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/entities/chat/messagebody.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConversationModel extends ChangeNotifier {
  final _buildContext;
  final _conversationService = ConversationService();
  final List<Message> _messages = List();

  Conversation _currentConversation;
  bool _sendMessageErrorIsPresent = false;
  MessageBody _lastFailedSendMessage = MessageBody();

  ConversationModel(this._buildContext, this._currentConversation);

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);
  Conversation get conversation => (this._currentConversation);
  bool get sendMessageErrorOccurred => (this._sendMessageErrorIsPresent);
  MessageBody get lastFailedSendMessage => (this._lastFailedSendMessage);

  ///
  /// Loads the messages handed from FutureBuilder
  /// into the model.
  ///
  void initMessages(List<Message> messages) {
    this._messages.clear();
    this._messages.addAll(messages);
  }

  ///
  /// Clears the state of the model
  ///
  void clear() {
    this._messages.clear();
    this._currentConversation.firstMessageId = 0;
    this._currentConversation.lastMessageId = 0;
    this.clearErrorState();
    notifyListeners();
  }


  ///
  /// Clear the current error state and notifies the UI
  ///
  void clearErrorState() {
    this._sendMessageErrorIsPresent = false;
    this._lastFailedSendMessage = MessageBody();
    notifyListeners();
  }

  ///
  /// Asks the server to get all messages, if successful
  /// the local list is overwritten and UI is notified
  ///
  Future<void> reloadAllMessages() async {
    List<Message> reloadResult = List();
    reloadResult = await _conversationService.getMessageUpdates(
        this._buildContext, this._currentConversation.id, null);
    if (reloadResult.isNotEmpty) {
      this._messages.clear();
      this._messages.addAll(reloadResult);
      notifyListeners();
    }
  }

  ///
  ///  Used to send a message using a MessageBody.
  ///  If successfully sent, the current data in model is updated
  ///
  ///  To display the newly sent message, a request to ask for new
  ///  messages is also sent afterwards. If the send attempt fails,
  ///  a error state is raised, and the UI will get notified
  ///
  Future<void> sendMessage(MessageBody message) async {
    try {
      Conversation result = await _conversationService.sendMessageRequest(
          this._buildContext, this._currentConversation.id, message);
      if (result != null) {
        print('MODEL: Sendt message OK');
        _sendMessageErrorIsPresent = false;
        _lastFailedSendMessage = MessageBody();
        this.loadNewMessages();
        this._currentConversation = result;
      } else {
        _sendMessageErrorIsPresent = true;
        _lastFailedSendMessage = message;
        notifyListeners();
      }
    } on Exception {
      _sendMessageErrorIsPresent = true;
      _lastFailedSendMessage = message;
      notifyListeners();
    }
  }

  ///
  ///  Loads new or missing messages from the server, by checking
  ///  the last id of the last message in the model.
  ///
  Future<void> loadNewMessages() async {
    num lastMsgIdInList = this._lastMessageIdInList;
    num lastMsgIdInMetadata = this._currentConversation.lastMessageId;
    print('MODEL: Last message IDs: list:metadata= ' +
        lastMsgIdInList.toString() +
        ':' +
        lastMsgIdInMetadata.toString());
    List<Message> tailMessageListResult = List();
    try {
      tailMessageListResult = await _conversationService.getMessageUpdates(
          this._buildContext, this._currentConversation.id, lastMsgIdInList);
      if (tailMessageListResult != null && tailMessageListResult.isNotEmpty) {
        print('MODEL: Added ' +
            tailMessageListResult.length.toString() +
            'messages from server.');
        this._messages.addAll(tailMessageListResult);
        notifyListeners();
      }
    } on Exception catch (e) {}
  }

  ///
  /// Used to return the message id of the last message in list.
  /// if list is, empty we return null.
  ///
  /// In the event of a empty list, the server will take null as message id
  /// and try to load all messages
  ///
  num get _lastMessageIdInList {
    // may be empty in a new conversation with no messages
    if (this._messages.isEmpty) {
      return null;
    } else {
      return this._messages.last.id;
    }
  }


}
