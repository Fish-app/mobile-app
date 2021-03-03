import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/utils/services/auth_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/display_text_field.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/nav_widgets/row_topbar_return.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

import '../../widgets/rating_stars.dart';
import '../../widgets/rating_stars.dart';

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
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(
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
                      Consumer<AppState>(builder: (context, value, child) {
                        return Column(children: [
                          // TODO: ALIGN THIS BETTER
                          Align(
                            child: Text(
                              "your rating".toUpperCase(),
                              style: Theme.of(context).textTheme.overline,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          UserRatingStars(user: value.user),
                          // TODO-end

                          DisplayTextField(
                              description: S.of(context).name.toUpperCase(),
                              content: value.user?.name ?? ""),
                          DisplayTextField(
                              description: S.of(context).email.toUpperCase(),
                              content: value.user?.email ?? ""),
                          DisplayTextField(
                              description: "session valid until".toUpperCase(),
                              content:
                                  value.jwtTokenData?.expiresAt.toString() ??
                                      ""),
                        ]);
                      }),
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
                            AuthService.logout(context);
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
