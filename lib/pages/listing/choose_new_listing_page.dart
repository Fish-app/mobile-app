import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:***REMOVED***/widgets/nav_widgets/common_nav.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/widgets/standard_button.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;


import 'package:***REMOVED***/widgets/nav_widgets/floating_nav_bar.dart';


class ChooseNewListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return get***REMOVED***DefaultScaffold(context,
      useNavBar: navButtonNewListing,
      includeTopBar: S.of(context).newListing,
      extendBehindAppBar: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: StandardButton(
                buttonText: S.of(context).newListing,
                onPressed: () => Navigator.pushNamed(context, routes.NewListing)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: StandardButton(
                buttonText: "New order",
                onPressed: () => _doNothing()
            ),
          ),
        ],
      )
    );
  }

  _doNothing() {
  }

}