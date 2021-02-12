import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:maoyi/entities/user.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/widgets/display_text_field.dart';
import 'package:maoyi/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/widgets/nav_widgets/common_nav.dart';
import 'package:maoyi/widgets/nav_widgets/row_topbar_return.dart';
import 'package:maoyi/widgets/standard_button.dart';
import 'package:strings/strings.dart';

class UserPage extends StatefulWidget {
  final _buttonColor = Colors.amber;
  final _buttonPadding = 10.0;
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
      Navigator.of(context).popAndPushNamed(routes.UserLogin);
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
    return getMaoyiDefaultScaffold(
      context,
      useNavBar: navButtonUser,
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
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
                      Container(
                        padding: EdgeInsets.only(bottom: 29),
                        child: Text(
                          "User info",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 24.0),
                        ),
                      ),
                      // USER INFO
                      DisplayTextField(
                          description: S.of(context).name.toUpperCase(),
                          content: fullname),
                      DisplayTextField(
                          description: S.of(context).email.toUpperCase(),
                          content: email),
                      DisplayTextField(
                          description: "session valid until".toUpperCase(),
                          content:
                              JwtDecoder.getExpirationDate(_token).toString()),
                      // BUTTONS
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: widget._buttonPadding),
                        child: StandardButton(
                          buttonText: capitalize(S.of(context).changePassword),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.UserResetPwd);
                          },
                        ),
                      ),
                      Visibility(
                        //TODO: IMPLEMENT SELLER IN OTHER PULL REQ
                        visible: true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: widget._buttonPadding),
                          child: StandardButton(
                            buttonText: capitalize(S.of(context).becomeSeller),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: widget._buttonPadding),
                        child: StandardButton(
                          buttonText: capitalize("Logout"),
                          onPressed: () {
                            AuthService.logout();
                            Navigator.of(context)
                                .popAndPushNamed(routes.UserLogin);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: widget._buttonPadding),
                        child: StandardButton(
                          buttonText: capitalize(S.of(context).deleteUser),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.UserResetPwd);
                          },
                        ),
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
