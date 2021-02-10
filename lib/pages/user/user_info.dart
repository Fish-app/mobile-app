import 'package:flutter/material.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/widgets/floating_nav_bar.dart';
import 'package:***REMOVED***/widgets/form_user_resetpwd.dart';
import 'package:***REMOVED***/widgets/standard_button.dart';

class UserInfoPage extends StatefulWidget {
  final _spacing = 24.0;
  final _buttonColor = Colors.amber;
  @override
  State<StatefulWidget> createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ***REMOVED***NavBar(
          currentActiveButton: navButtonUser,
        ),
        body: Container(
          child: Column(
            children: [
              AppBar(
                title: Text("User"),
                textTheme: Theme.of(context).primaryTextTheme.copyWith(
                  bodyText1: TextStyle(
                  )
                ),
                backgroundColor: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserAttributteDisplay(
                        title: "Name",
                        data: "Oluf Fisker",
                      ),
                      UserAttributteDisplay(
                          title: "Email", data: "asdasd@asdasd.ds"),
                      SizedBox(height: widget._spacing),
                      RaisedButton(
                        onPressed: () {},
                        color: widget._buttonColor,
                        child: const Text("Change password"),
                      ),
                      Visibility(
                        //FIXME: check seller, maybe statefuell ?
                        visible: true,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            0, widget._spacing, 0, 0,
                          ),
                          child: RaisedButton(
                            onPressed: () {},
                            color: widget._buttonColor,
                            child: const Text("Become seller"),
                          ),
                        ),
                      ),
                      SizedBox(height: widget._spacing),
                      RaisedButton(
                        onPressed: () {},
                        color: widget._buttonColor,
                        child: const Text("Delete user"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserAttributteDisplay extends StatefulWidget {
  final String title;
  final String data;

  const UserAttributteDisplay({
    Key key,
    @required this.title,
    @required this.data,
  }) : super(key: key);

  @override
  _UserAttributteDisplayState createState() => _UserAttributteDisplayState();
}

class _UserAttributteDisplayState extends State<UserAttributteDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(widget.title),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(widget.data),
        ),
      ],
    );
  }
}
