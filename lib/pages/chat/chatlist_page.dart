import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';

class ChatListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatListPageState();
}

class ChatListPageState extends State<ChatListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(
        context,
      includeTopBar: "Chat list",
      useNavBar: navButtonChat,
      child: SafeArea(
          child: Container(
            child: ListView(),
      )
      )
    );
  }
}
