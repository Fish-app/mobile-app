import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import '../../utils/services/rest_api_service.dart';

class ChatListPage extends StatefulWidget {
  final ConversationService _conversationService = ConversationService();

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        includeTopBar: capitalize(S.of(context).chatList),
        useNavBar: navButtonChat,
        child: SafeArea(
            child: appFutureBuilder<List<Conversation>>(
                widget._conversationService.getAllConversations(context, true),
                (conversations, context) {
          return Consumer<AppState>(builder: (context, userdata, child) {
            return Container(
              child: ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        return Navigator.of(context).pushNamed(
                            routes.ChatConversation,
                            arguments: conversations[index]);
                      },
                      child: ConversationListTile(
                        conversation: conversations[index],
                        localUser: userdata.user,
                      ))),
            );
          });
        })));
  }
}

class ConversationListTile extends StatelessWidget {
  final _formattedDate = DateFormat('dd/MM/yyyy');
  final _formattedTime = DateFormat('HH:mm');
  final Conversation conversation;
  final User localUser;

  ConversationListTile({Key key, this.conversation, this.localUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String _prefixStartChat = capitalize(S.of(context).chatWithPrefix);
    User _remoteUser;
    if (conversation.listing.creator.id == localUser.id) {
      _remoteUser = conversation.starterUser;
    } else {
      _remoteUser = conversation.listing.creator;
    }

    DateTime _lastChangedDate = (conversation.lastMessage != null)
        ? DateTime.fromMillisecondsSinceEpoch(
            conversation.lastMessage.createdDate)
        : DateTime.fromMillisecondsSinceEpoch(conversation.createdDate);

    return Container(
      child: ListTile(
          trailing: Text(_formattedDate.format(_lastChangedDate)),
          title: Text(_prefixStartChat + " " + _remoteUser.name),
          subtitle: conversation.lastMessage != null
              ? Text(getMessagePreviewText(
                  conversation.lastMessage, localUser, _remoteUser))
              : Text(capitalize(S.of(context).newConversation))),
    );
  }

  ///
  ///  Create a preview of the last sent message in the list with sender + time
  ///
  String getMessagePreviewText(Message message, User u1, User u2) {
    String messageText = message.content;
    String messageSent = _formattedTime
        .format(DateTime.fromMillisecondsSinceEpoch(message.createdDate));
    if (message.content.length > 10) {
      messageText = messageText.substring(0, 10) + "...";
    }
    if (message.senderId == u1.id) {
      return  u1.name + ": " + messageText;
      //return messageSent + " - " + u1.name + ": " + messageText;
    } else if (message.senderId == u2.id) {
      return  u2.name + ": " + messageText;
      //return messageSent + " - " + u2.name + ": " + messageText;
    } else {
      return null;
    }
  }
}
