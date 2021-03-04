import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
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
        includeTopBar: "Chat list",
        useNavBar: navButtonChat,
        child: SafeArea(
            child: appFutureBuilder<List<Conversation>>(
                widget._conversationService.getAllConversations(context),
                (conversations, context) {
          return Container(
            child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        return Navigator.of(context).pushNamed(
                            routes.ChatConversation,
                            arguments: conversations[index]);
                      },
                      child: ListTile(
                        leading: FlutterLogo(size: 48.0),
                        title: Text('Samtale med ' +
                            '${conversations[index].listing.creator.name}'),
                        subtitle: Text("meldingstekst her"),
                      ),
                    )),
          );
        })));
  }
}
