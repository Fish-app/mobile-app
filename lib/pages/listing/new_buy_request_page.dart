import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/pages/listing/form_new_buy_request.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewBuyRequestPage extends StatelessWidget {
  final GenericRouteData routeData;

  NewBuyRequestPage({this.routeData});

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        extendBehindAppBar: true,
        extendBody: true,
        useNavBar: navButtonNewListing,
        bgDecor: [
          CircleThingy(
            sizeX: 1000,
            sizeY: 800,
            centerX: 90,
            centerY: -200,
            top: true,
            left: true,
          ),
          CircleThingy(
            sizeX: 700,
            sizeY: 500,
            centerX: -60,
            centerY: -150,
            top: false,
            left: false,
          ),
        ],
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            bottom: false,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  S.of(context).newBuyRequest,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 24.0),
                ),
                NewBuyRequestForm(
                  routeData: routeData,
                )
              ],
            ),
          ),
        ));
  }
}
