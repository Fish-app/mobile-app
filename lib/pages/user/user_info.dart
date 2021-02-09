import 'package:flutter/material.dart';
import 'package:***REMOVED***/widgets/floating_nav_bar.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ***REMOVED***NavBar(
        currentActiveButton: navButtonUser,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(

            ),
            AppBar(
             backgroundColor: Theme.of(context).backgroundColor,
            )
          ],
        ),
      ),
    );
  }
}
