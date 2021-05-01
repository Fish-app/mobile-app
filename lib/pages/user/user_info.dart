import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/auth/jwt.dart';
import 'package:fishapp/utils/services/auth_service.dart';
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

  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(
      context,
      extendBehindAppBar: true,
      useNavBar: navButtonUser,
      includeTopBar: S.of(context).userInfo,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<AppState>(builder: (context, value, child) {
                          return Column(children: [
                            DefaultCard(
                              children: [
                                Align(
                                  child: Text(
                                    S.of(context).yourRating.toUpperCase(),
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
                                    description: S
                                        .of(context)
                                        .sessionValidUntil
                                        .toUpperCase(),
                                    content:
                                        DateTime.fromMillisecondsSinceEpoch(
                                                    _toReadableDate(
                                                        value.jwtTokenData),
                                                    isUtc: true)
                                                .toString()
                                                .substring(0, 10) ??
                                            ""),
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
                          buttonText: camelize(S.of(context).logout),
                          buttonIcon: Icons.logout,
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.RECEIPTS_LIST);
                          },
                          buttonText: camelize(S.of(context).goToReceipts),
                          buttonIcon: Icons.receipt_long,
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {},
                          buttonText: camelize(S.of(context).goToListings),
                          buttonIcon: Icons.list_alt,
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.USER_RESET_PWD);
                          },
                          buttonText: camelize(S.of(context).changePassword),
                          buttonIcon: Icons.vpn_key,
                        ),

                        ButtonV2(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(routes.RECEIPTS_LIST);
                          },
                          buttonText: camelize(S.of(context).deleteUser),
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
}
