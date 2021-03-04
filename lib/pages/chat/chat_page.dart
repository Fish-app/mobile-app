import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/material.dart';

class ChatMessagePage extends StatefulWidget {
  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: getFishappDefaultScaffold(
          context,
        includeTopBar: "Chat",
        child: Container(
        )
      ),
    );
  }
}
