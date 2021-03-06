import 'package:fishapp/entities/chat/messagebody.dart';
import 'package:fishapp/pages/chat/conversation_model.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

class ChatBubbleFromError extends StatelessWidget {
  final MessageBody failedMessage;

  const ChatBubbleFromError({Key key, @required this.failedMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      backGroundColor: Colors.red,
      alignment: Alignment.topRight,
      clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
      child: Column(
        children: [
          Text(capitalize(S.of(context).error)),
          Text(capitalize(S.of(context).unableToSend) + ": " + failedMessage.messageText,
              style: TextStyle(color: Colors.white)),
          StandardButton(
              buttonText: capitalize(S.of(context).actionTryAgain),
              onPressed: () {
                Provider.of<ConversationModel>(context)
                    .sendMessage(failedMessage);
              })
        ],
      ),
    );
  }
}
