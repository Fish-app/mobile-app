import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maoyi/widgets/nav_widgets/common_nav.dart';
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/widgets/standard_button.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;


import 'package:maoyi/widgets/nav_widgets/floating_nav_bar.dart';


class ChooseNewListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getMaoyiDefaultScaffold(context,
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