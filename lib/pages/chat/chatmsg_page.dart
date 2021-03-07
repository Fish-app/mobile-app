import 'dart:async';

import 'package:async/async.dart';
import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/pages/chat/form_send_chatmsg.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/chat/chatbubble_error.dart';
import 'package:fishapp/widgets/chat/chatbubble_message.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'conversation_model.dart';


class ChatMessagePage extends StatelessWidget {
  final Conversation baseConversation;
  final scrollController = ScrollController();

  ChatMessagePage({Key key, @required this.baseConversation}) : super(key: key);

  //FIXME: current future builder does not support empty list
  //FIXME: Fix that main column is not redrawed on keyboard popup,
  // or migrate init state/futurebuilder so that initalisation happens
  // outside of build below

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConversationModel(context, baseConversation),
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom,
        ),
        child: SafeArea(
            child: getFishappDefaultScaffold(context,
                includeTopBar: baseConversation.listing.creator.name,
                extendBehindAppBar: false, child: Consumer<AppState>(
                  builder: (context, userdata, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // CHAT MESSAGE LISTS
                        Consumer<ConversationModel>(
                            builder: (context, model, child) =>
                                Visibility(
                                  visible: model.sendMessageErrorOccurred,
                                  child: ChatBubbleFromError(
                                      failedMessage: model
                                          .lastFailedSendMessage),
                                )),
                        MessageListWidget(
                            baseConversation: baseConversation,
                            userdata: userdata,
                            scrollController: scrollController),
                        // CHAT WRITE MESSAGE BAR
                        SendChatMessageForm(),

                        //TODO: REMOVE DEBUG BUTTONS
                        // DEBUG BUTTONS
                        ElevatedButton(
                            style: Theme
                                .of(context)
                                .elevatedButtonTheme
                                .style,
                            child: Text(
                              "refresh/hold to vekk",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .button,
                            ),
                            onLongPress: () {
                              Provider.of<ConversationModel>(
                                  context, listen: false)
                                  .clear();
                            },
                            onPressed: () {
                              Provider.of<ConversationModel>(
                                  context, listen: false)
                                  .reloadAllMessages();
                            }),
                        StandardButton(
                            buttonText: "ned",
                            onPressed: () {
                              scrollController.animateTo(
                                  scrollController.position.minScrollExtent,
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

class MessageListWidget extends StatefulWidget {
  final _conversationService = ConversationService();
  final baseConversation;
  final userdata;
  final scrollController;

  MessageListWidget(
      {Key key, this.baseConversation, this.userdata, this.scrollController})
      : super(key: key);
  @override
  _MessageListWidgetState createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  CancelableOperation _ftrTimerLoadMsgs;
  Timer _timer;


  @override
  void dispose() {
    _timer?.cancel();
    _ftrTimerLoadMsgs?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      print('WIDGET: Timer did run');
      _ftrTimerLoadMsgs = CancelableOperation.fromFuture(
          Provider.of<ConversationModel>(context, listen: false)
              .loadNewMessages());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: appFutureBuilder<List<Message>>(
          widget._conversationService
              .getMessageUpdates(context, widget.baseConversation.id, null),
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
                controller: widget.scrollController,
                itemCount: model.messages.length,
                itemBuilder: (context, index) {
                  // scroll to bottom
                  // https://stackoverflow.com/a/58924439
                  final reversedIndex = model.messages.length - 1 - index;
                  final message = model.messages[reversedIndex];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: ChatBubbleFromMessage(
                      message: message,
                      loggedInUserId: widget.userdata.user.id,
                    ),
                  );
                }),
          ),
        );
      }),
    );
  }
}
