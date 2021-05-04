import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/auth/jwt.dart';
import 'package:fishapp/utils/payment_webview.dart';
import 'package:fishapp/utils/services/auth_service.dart';
import 'package:fishapp/utils/services/subscription_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/display_text_field.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

import '../../widgets/rating_stars.dart';

class UserPage extends StatefulWidget {
  final _buttonColor = Colors.amber;
  final _buttonPadding = 10.0;
  final subService = SubscriptionService();
  bool _isSubscribed = false;

  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    _getIsSubscriptionValid();
    return getFishappDefaultScaffold(
      context,
      extendBehindAppBar: true,
      useNavBar: navButtonUser,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleThingy(
            sizeX: MediaQuery.of(context).size.width * 2 + 150,
            sizeY: MediaQuery.of(context).size.width * 2 + 50,
            centerX: -50,
            centerY: 0,
            left: false,
            top: true,
          ),
          Container(
            child: ListView(
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
                            DefaultCard(
                              children: [
                                Align(
                                  child: Text(
                                    "your rating".toUpperCase(),
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                UserRatingStars(user: value?.user),
                                DisplayTextField(
                                    description:
                                        S.of(context).name.toUpperCase(),
                                    content: value.user?.name ?? ""),
                                DisplayTextField(
                                    description:
                                        S.of(context).email.toUpperCase(),
                                    content: value.user?.email ?? ""),
                                DisplayTextField(
                                    description:
                                        "session valid until".toUpperCase(),
                                    content:
                                        DateTime.fromMillisecondsSinceEpoch(
                                                    _toReadableDate(
                                                        value.jwtTokenData),
                                                    isUtc: true)
                                                .toString()
                                                .substring(0, 10) ??
                                            ""
                                    //value.jwtTokenData?.expiresAt.toString()
                                    ),
                              ],
                            ),
                          ]);
                        }),
                        // BUTTONS

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                routes.HOME, ModalRoute.withName(routes.HOME));
                            AuthService.logout();
                          },
                          buttonText: "Logout",
                          buttonIcon: Icons.logout,
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.RECEIPTS_LIST);
                          },
                          buttonText: "Go To Recepts",
                          buttonIcon: Icons.receipt_long,
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {},
                          buttonText: "Go To Listings",
                          buttonIcon: Icons.list_alt,
                        ),

                        Visibility(
                          child: _displaySubscriptionButton(),
                          visible: AppState().isSeller(),
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.USER_RESET_PWD);
                          },
                          buttonText: "Change password",
                          buttonIcon: Icons.vpn_key,
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.RECEIPTS_LIST);
                          },
                          buttonText: "Delete User",
                          buttonIcon: Icons.delete,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _toReadableDate(JwtTokenData jwtTokenData) {
    if (jwtTokenData != null) {
      return (jwtTokenData.expiresAt * 1000).toInt();
    } else {
      return 1;
    }
  }

  void _getIsSubscriptionValid() async {
    User user = Provider.of<AppState>(context, listen: false)?.user;
    bool isValid = await widget.subService.getIsSubscriptionValid(user.id);
    setState(() {
      widget._isSubscribed = isValid;
    });
  }

  Widget _displaySubscriptionButton() {
    if (widget._isSubscribed) {
      return ButtonV2(
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: () {
          Navigator.of(context).pushNamed(routes.SUBSCRIPTION_INFO);
        },
        buttonText: camelize(S.of(context).viewSubscription),
        buttonIcon: Icons.view_list_outlined,
      );
    } else {
      return ButtonV2(
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: () {
          var a = new SubscriptionService();
          a.getNewSubscription().then((value) {
            print(value.hostedPaymentPageUrl);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentWebview(
                    killUrl: "http://foo.bar",
                    startUrl: value.hostedPaymentPageUrl,
                  ),
                ));
          });
        },
        buttonText: capitalize(S.of(context).subscribe),
        buttonIcon: Icons.assignment_turned_in,
      );
    }
  }
}
