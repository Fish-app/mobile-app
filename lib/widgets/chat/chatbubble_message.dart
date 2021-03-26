import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class ChatBubbleFromMessage extends StatelessWidget {
  final Message message;
  final num loggedInUserId;

  const ChatBubbleFromMessage(
      {Key key, @required this.message, @required this.loggedInUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("Drawing message id:" + message.id.toString());

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ChatBubble(
        backGroundColor: _isSenderLoggedInUser(message)
            ? emphasisColor
            : Color(0xffE7E7ED),
        alignment: _isSenderLoggedInUser(message)
            ? Alignment.topRight
            : Alignment.topLeft,
        clipper: ChatBubbleClipper5(
          type: _isSenderLoggedInUser(message)
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble,
        ),
        child: Text(message.content,
            style: TextStyle(
                color: _isSenderLoggedInUser(message)
                    ? Colors.black
                    : Colors.black)),
      ),
    );
  }

  bool _isSenderLoggedInUser(Message message) {
    if (loggedInUserId == message.senderId) {
      return true;
    } else {
      return false;
    }
  }
}
