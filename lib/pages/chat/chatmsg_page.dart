import 'dart:async';

import 'package:async/async.dart';
import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/pages/chat/form_send_chatmsg.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/buttons_navigate_to_listing.dart';
import 'package:fishapp/widgets/chat/chatbubble_error.dart';
import 'package:fishapp/widgets/chat/chatbubble_message.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'conversation_model.dart';

class ChatMessagePage extends StatelessWidget {
  final Conversation baseConversation;
  final scrollController = ScrollController();

  ChatMessagePage({Key key, @required this.baseConversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConversationModel(context, baseConversation),
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Consumer<AppState>(builder: (context, userdata, child) {
          User remoteParticipant;
          User localParticipant = userdata.user;
          if (baseConversation.listing.creator.id == localParticipant.id) {
            remoteParticipant = baseConversation.starterUser;
          } else {
            remoteParticipant = baseConversation.listing.creator;
          }
          String topBartext = remoteParticipant.name;

          return getFishappDefaultScaffold(context,
              includeTopBar: topBartext,
              extendBehindAppBar: false,
              navBarActions: <Widget>[
                NavigateToListingButton(
                  conv_listing: baseConversation.listing,
                )
              ],
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // CHAT MESSAGE LISTS
                    MessageListWidget(
                        baseConversation: baseConversation,
                        localParticipant: localParticipant,
                        scrollController: scrollController),
                    // ERROR ON SEND MESG
                    Consumer<ConversationModel>(
                        builder: (context, model, child) => Visibility(
                              visible: model.sendMessageErrorOccurred,
                              child: ChatBubbleFromError(
                                  failedMessage: model.lastFailedSendMessage),
                            )),
                    // CHAT WRITE MESSAGE BAR
                    SendChatMessageForm(),
                  ],
                ),
              ));
        }),
      ),
    );
  }
}

class MessageListWidget extends StatefulWidget {
  final Conversation baseConversation;
  final User localParticipant;
  final ScrollController scrollController;

  MessageListWidget(
      {Key key,
      this.baseConversation,
      this.localParticipant,
      this.scrollController})
      : super(key: key);

  @override
  _MessageListWidgetState createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  CancelableOperation _ftrTimerLoadMsgs;
  Timer _timer;

  final bool _debug = false;

  @override
  void dispose() {
    _timer?.cancel();
    _ftrTimerLoadMsgs?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<ConversationModel>(context, listen: false).loadNewMessages();

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (this._debug) print('WIDGET: Timer did run');
      _ftrTimerLoadMsgs = CancelableOperation.fromFuture(
          Provider.of<ConversationModel>(context, listen: false)
              .loadNewMessages());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ConversationModel>(
        builder: (context, model, child) => Container(
          child: ListView.builder(
              reverse: true,
              controller: widget.scrollController,
              itemCount: model.messages.length,
              itemBuilder: (context, index) {
                // scroll to bottom
                // https://stackoverflow.com/a/58924439
                final reversedIndex = model.messages.length - 1 - index;
                final message = model.messages[reversedIndex];
                return ChatBubbleFromMessage(
                  message: message,
                  loggedInUserId: widget.localParticipant.id,
                );
              }),
        ),
      ),
    );
  }
}
