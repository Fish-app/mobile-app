import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/widgets/floating_nav_bar.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/widgets/row_topbar_return.dart';
import 'package:strings/strings.dart';

class UserPage extends StatefulWidget {
  final _buttonColor = Colors.amber;
  final String email;
  final String fullname;
  final bool isSeller;

  UserPage({Key key, this.email, this.fullname, this.isSeller})
      : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    _setUserDetails();
    _setIsSeller();
  }

  void _setUserDetails() async {
    User user = await AuthService.isUserLoggedIn();
    String jwtFromAuth = await AuthService.getTokenFromStorage();
    if (user == null || jwtFromAuth == null) {
      Navigator.of(context).pushNamed(routes.UserLogin);
    } else {
      setState(() {
        this.email = user.email;
        this.fullname = user.name;
        this._token = jwtFromAuth;
      });
    }
  }

  void _setIsSeller() async {
    // todo: the fetching and check for is seller here
    await Future.delayed(Duration(milliseconds: 30));
    setState(() {
      this.isSeller = true;
    });
  }

  bool isSeller = false;
  String email = "";
  String fullname = "";
  String _token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ***REMOVED***NavBar(
        currentActiveButton: navButtonUser,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [

              // TOP ROW
              TopBarRow(title: "User"),

              // MAIN WINDOW
              Container(
               // color: Colors.black38,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // USER INFO
                      UserInfoField(label: S.of(context).name, data: fullname),
                      UserInfoField(label: S.of(context).email, data: email),
                      UserInfoField(
                          label: "session valid until",
                          data: JwtDecoder.getExpirationDate(_token).toString()),
                      // BUTTONS
                      RaisedButton(
                        onPressed: () {
                          //TODO: IMPLEMENT CHANGE PASSWORD PAGE
                          // change password
                          // call logout of OK
                          Navigator.of(context).pushNamed(routes.UserResetPwd);
                        },
                        color: widget._buttonColor,
                        child: Text(capitalize(S.of(context).changePassword)),
                      ),
                      Visibility(
                        //TODO: IMPLEMENT SELLER PRIVILIGELES CHECKS
                        visible: true,
                        child: RaisedButton(
                          onPressed: () {},
                          color: widget._buttonColor,
                          child: Text(capitalize(S.of(context).becomeSeller)),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          AuthService.logout();
                          Navigator.pushNamedAndRemoveUntil(context, routes.Home, (r) => false);
                        },
                        color: widget._buttonColor,
                        child: const Text("Logout test"),
                      ),
                      RaisedButton(
                        //onPressed: () {},
                        color: widget._buttonColor,
                        child: Text(capitalize(S.of(context).deleteUser)),
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


class UserInfoField extends StatelessWidget {
  const UserInfoField({
    Key key,
    @required this.label,
    @required this.data,
  }) : super(key: key);

  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase()),
          SizedBox(height: 6.0),
          Text(capitalize(data)),
          Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
