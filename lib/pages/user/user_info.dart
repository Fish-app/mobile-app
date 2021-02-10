import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';
import 'package:***REMOVED***/widgets/floating_nav_bar.dart';
import 'package:***REMOVED***/widgets/form_user_resetpwd.dart';
import 'package:***REMOVED***/widgets/standard_button.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:strings/strings.dart';

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
        body: FutureBuilder<User>(
            future: AuthService.isUserLoggedIn(),
            builder: (BuildContext ctx, AsyncSnapshot <User>snapshot) {
                if (snapshot.data == null) {
                  /// No user data found, tell user to authenticate
                  //Navigator.pushNamed(context, routes.UserLogin);
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You must login to acces this page."),
                        RaisedButton(
                            color: widget._buttonColor,
                            child: Text(S.of(context).loginUser),
                            onPressed: () {
                              Navigator.pushNamed(context, routes.UserLogin);
                            })
                      ],
                    ),
                  );
                  /// Got user == Session is valid, and ready to be displayed
                } else {
                  return Column(
                    children: [
                      AppBar(
                        title: Text("User"),
                        textTheme: Theme.of(context)
                            .primaryTextTheme
                            .copyWith(bodyText1: TextStyle()),
                        backgroundColor: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your account"),
                              UserAttributteDisplay(
                                title: capitalize(S.of(context).name),
                                data: snapshot.data.name,
                              ),
                              UserAttributteDisplay(
                                  title: capitalize(S.of(context).email),
                                  data: snapshot.data.email
                              ),
                              SizedBox(height: widget._spacing),
                              //TODO: MA80
                              //TODO: MIGRATE TO SELLERS CARDS
                              Text("Seller information"),
                              SizedBox(height: widget._spacing),
                              RaisedButton(
                                onPressed: () {
                                  //TODO: MA107
                                  //TODO: IMPLEMENT CHANGE PASSWORD PAGE
                                  // change password
                                  // call logout of OK
                                },
                                color: widget._buttonColor,
                                child: Text(capitalize(S.of(context).changePassword)),
                              ),
                              Visibility(
                                //TODO: MA80 MA83
                                //TODO: IMPLEMENT SELLER PRIVILIGELES CHECKS
                                visible: true,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    widget._spacing,
                                    0,
                                    0,
                                  ),
                                  child: RaisedButton(
                                    onPressed: () {},
                                    color: widget._buttonColor,
                                    child: Text(capitalize(S.of(context).becomeSeller)),
                                  ),
                                ),
                              ),
                              SizedBox(height: widget._spacing),
                              RaisedButton(
                                //onPressed: () {},
                                color: widget._buttonColor,
                                child: Text(capitalize(S.of(context).deleteUser)),
                              ),
                              SizedBox(height: widget._spacing),
                              RaisedButton(
                                onPressed: () {
                                  AuthService.logout();
                                  Navigator.pushNamedAndRemoveUntil(context, routes.Home, (r) => false);
                                },
                                color: widget._buttonColor,
                                child: const Text("Logout test"),
                              ),
                              /// Currently for debug, will be removed when auth
                              /// system is shown to be stable and working
                              Text("SESSION IS"),
                            FutureBuilder<bool>(
                                future: AuthService.isPersistedTokenValid(),
                                builder: (BuildContext context, AsyncSnapshot <bool>tokenStatus) {
                                  if (tokenStatus.hasData) {
                                    return tokenStatus.data ? Text("VALID") : Text("EXPIRED");
                                  } else {
                                    return Text("MISSING");
                                  }
                                },
                              ),
                              FutureBuilder<String>(
                                future: AuthService.getTokenFromStorage(),
                                builder: (BuildContext ctx, AsyncSnapshot <String>tokenShot) {
                                  if (tokenShot.hasData) {
                                    String date = JwtDecoder.getExpirationDate(tokenShot.data).toString();
                                    return Container(
                                      child: Text("GOT TOKEN - VALID TO " + date),
                                    );
                                  } else {
                                    return Container(
                                        child: Text("NO TOKEN"),
                                    );
                                  }
                                }),
                                ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
            }),
      ),
    );
  }
}

class UserAttributteDisplay extends StatefulWidget {
  //TODO: MA80
  //TODO: TO BE IMPROVED IN OWN TASK
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
