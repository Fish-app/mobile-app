import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatMessagePage extends StatefulWidget {
  final ConversationService _conversationService = ConversationService();
  final Conversation conversation;

  ChatMessagePage({Key key, @required this.conversation})
      : super(key: key);

  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  List<Message> messages = List();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: getFishappDefaultScaffold(
      context,
      includeTopBar: widget.conversation.listing.creator.name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: appFutureBuilder<List<Message>>(
                widget._conversationService.getAllMessagesInConversation(
                    context, widget.conversation.id),
                (messagesFromServer, context) {
                  return Container(

                  );
                }
            ),
          ),
          Row(
            children: [
              FlutterLogo(size: 48.0,),
              StandardButton(buttonText: "Send", onPressed: null)
            ],
          )
        ],
      ),
    ));
  }
}

class _buildChatBubbleFromMessage extends StatelessWidget {
  final Message message;

  const _buildChatBubbleFromMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChatBubble(),
    );
  }
}
