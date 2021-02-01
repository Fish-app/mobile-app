import 'package:flutter/material.dart';
import 'package:***REMOVED***/widgets/floating_nav_bar.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ***REMOVED***NavBar(
        currentActiveButton: navButtonChat,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Chat Page"),
            ],
          ),
        ),
      ),
    );
  }
}
