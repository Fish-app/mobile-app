import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseNewListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        useNavBar: navButtonNewListing,
        includeTopBar: S.of(context).newListing,
        extendBehindAppBar: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: StandardButton(
                  buttonText: S.of(context).newListing,
                  onPressed: () =>
                      Navigator.pushNamed(context, routes.NEW_LISTING)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: StandardButton(
                  buttonText: S.of(context).newBuyRequest,
                  onPressed: () =>
                      Navigator.pushNamed(context, routes.NEW_BUY_REQUEST)),
            ),
          ],
        ));
  }

  _doNothing() {}
}
