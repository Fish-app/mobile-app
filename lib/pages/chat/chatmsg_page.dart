import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/utils/state/chatmsgstate.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:provider/provider.dart';

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
            child: getFishappDefaultScaffold(context,
                includeTopBar: widget.conversation.listing.creator.name,
                extendBehindAppBar: false, child: Consumer<AppState>(
          builder: (context, userdata, child) {
            return Column(
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
                        print("FUTURE builder: from srv result " + messagesFromServer.length.toString());
                        this.messages = messagesFromServer;

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: ChatBubbleFromMessage(
                                    message: messages[index],
                                    loggedInUserId: userdata.user.id,
                                  ),
                                )),
                      );
                  }),
                ),
                // CHAT WRITE MESSAGE BAR
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  child: Form(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.camera_alt), onPressed: null),
                        Flexible(
                          child: TextFormField(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: StandardButton(
                              buttonText: "Send", onPressed: null),
                        ),
                      ],
                    ),
                  ),
                ),
                StandardButton(buttonText: "refresh", onPressed: () async {
                  List<Message> refreshRequest
                  = await widget._conversationService
                      .getAllMessagesInConversation(context, widget.conversation.id);
                  setState(() {
                    this.messages = refreshRequest;
                  });
                }),
                StandardButton(buttonText: "clear", onPressed: () {
                  setState(() {
                    this.messages.clear();
                  });
                }),
              ],
            );
          },
        ))),
      );
  }
}

class ChatBubbleFromMessage extends StatelessWidget {
  final Message message;
  final num loggedInUserId;

  const ChatBubbleFromMessage(
      {Key key, @required this.message, @required this.loggedInUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Drawing message id:" + message.id.toString());

    return ChatBubble(
      //margin: EdgeInsets.only(top: 20),
      backGroundColor: _isSenderLoggedInUser(message)
          ? Color(0xff354ff6)
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
                  ? Colors.white
                  : Colors.black)),
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
