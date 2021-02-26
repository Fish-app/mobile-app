import 'package:flutter/material.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Chat Page"),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FishappNavBar(
                  currentActiveButton: navButtonShop,
                ),
              ),
            ],
          )),
    );
  }
}
