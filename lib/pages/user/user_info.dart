import 'package:flutter/material.dart';
import 'package:maoyi/widgets/floating_nav_bar.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MaoyiNavBar(
        currentActiveButton: navButtonUser,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("UserInfo Page"),
            ],
          ),
        ),
      ),
    );
  }
}
