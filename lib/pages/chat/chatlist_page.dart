import 'package:fishapp/entities/user.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
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
                widget._conversationService.getAllConversations(context),
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
                        child: ConversationListTile(conversation: conversations[index], currentUser: userdata.user,)
                      )),
            );
          });
        })));
  }
}

class ConversationListTile extends StatelessWidget {
  final Conversation conversation;
  final User currentUser;

  const ConversationListTile({Key key, this.conversation, this.currentUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(conversation.starterUser.name.toString());
    final String _prefixTileTitle= S.of(context).chatWithPrefix;
    User _remoteUser;
    if(conversation.listing.creator.id == currentUser.id) {
      _remoteUser = conversation.starterUser;
    } else {
      _remoteUser = conversation.listing.creator;
    }
    return Container(
      child:
      ListTile(
        leading: FlutterLogo(size: 48.0),
        title: Text(_prefixTileTitle + " " + _remoteUser.name),
        subtitle: Text("meldingstekst her"),
      ),
    );
  }
}

