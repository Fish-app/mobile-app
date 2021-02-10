import 'package:flutter/material.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';
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
      body: SafeArea(
        child: Stack(

          children: [
            ListView(
              children: [
                Text("SAdasasd"),
              ],
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
