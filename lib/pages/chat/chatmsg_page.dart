import 'package:fishapp/config/themes/theme_config.dart';
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

  ChatMessagePage({Key key, @required this.conversation}) : super(key: key);

  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  final _formKey = GlobalKey<FormState>();
  List<Message> messages = List();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
          child: getFishappDefaultScaffold(
        context,
        includeTopBar: widget.conversation.listing.creator.name,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CHAT MESSAGE LISTS
            Expanded(
              child: appFutureBuilder<List<Message>>(
                  widget._conversationService.getAllMessagesInConversation(
                      context, widget.conversation.id),
                  (messagesFromServer, context) {
                return Container();
              }),
            ),
            // CHAT WRITE MESSAGE BAR
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child:
              Form(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.camera_alt), onPressed: null),
                    Flexible(
                      child: TextFormField(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: StandardButton(buttonText: "Send", onPressed: null),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
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
