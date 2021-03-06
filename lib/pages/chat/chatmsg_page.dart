import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/pages/chat/form_send_chatmsg.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/chat/chatbubble_error.dart';
import 'package:fishapp/widgets/chat/chattbubble_message.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'conversation_model.dart';

class ChatMessagePage extends StatefulWidget {
  final Conversation baseConversation;

  ChatMessagePage({Key key, @required this.baseConversation}) : super(key: key);

  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  final ConversationService _conversationService = ConversationService();
  final _scrollController = ScrollController();

  //FIXME: Unicode/Nordic charcates
  //FIXME: Fix that main column is not redrawed on keyboard popup,
  // or migrate init state/futurebuilder so that initalisation happens
  // outside of build below

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConversationModel(context, widget.baseConversation),
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
            child: getFishappDefaultScaffold(context,
                includeTopBar: widget.baseConversation.listing.creator.name,
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
                      _conversationService.getMessageUpdates(
                          context, widget.baseConversation.id, null),
                      (messagesFromServer, context) {
                    print("FUTURE builder: from srv result " +
                        messagesFromServer.length.toString());

                    Provider.of<ConversationModel>(context, listen: false)
                        .initMessages(messagesFromServer);

                    return Consumer<ConversationModel>(
                      builder: (context, model, child) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                            reverse: true,
                            controller: _scrollController,
                            itemCount: model.messages.length,
                            itemBuilder: (context, index) {
                              // scroll to bottom
                              // https://stackoverflow.com/a/58924439
                              final reversedIndex =
                                  model.messages.length - 1 - index;
                              final message = model.messages[reversedIndex];
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: ChatBubbleFromMessage(
                                  message: message,
                                  loggedInUserId: userdata.user.id,
                                ),
                              );
                            }),
                      ),
                    );
                  }),
                ),
                Consumer<ConversationModel>(
                    builder: (context, model, child) => Visibility(
                          visible: model.sendMessageErrorOccurred,
                          child: ChatBubbleFromError(
                              failedMessage: model.lastFailedSendMessage),
                        )),
                // CHAT WRITE MESSAGE BAR
                SendChatMessageForm(),
                //

                //TODO: REMOVE DEBUG BUTTONS
                // DEBUG BUTTONS
                ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Text(
                      "refresh/hold to vekk",
                      style: Theme.of(context).textTheme.button,
                    ),
                    onLongPress: () {
                      Provider.of<ConversationModel>(context, listen: false)
                          .clear();
                    },
                    onPressed: () {
                      Provider.of<ConversationModel>(context, listen: false)
                          .reloadAllMessages();
                    }),
                StandardButton(
                    buttonText: "ned",
                    onPressed: () {
                      _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    }),
              ],
            );
          },
        ))),
      ),
    );
  }
}
