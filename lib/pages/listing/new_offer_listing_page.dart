import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/pages/listing/form_new_offer_listing.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOfferListingPage extends StatefulWidget {
  final GenericRouteData routeData;

  NewOfferListingPage({Key key, this.routeData}) : super(key: key);

  @override
  _NewOfferListingPageState createState() => _NewOfferListingPageState();
}

class _NewOfferListingPageState extends State<NewOfferListingPage> {
  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        extendBehindAppBar: true,
        useNavBar: navButtonNewOfferListing,
        includeTopBar: S.of(context).newOfferListing,
        bgDecor: [
          CircleThingy(
            sizeX: 1000,
            sizeY: 1200,
            centerX: -400,
            centerY: 200,
            top: false,
            left: true,
          ),
          CircleThingy(
            sizeX: 500,
            sizeY: 700,
            centerX: -150,
            centerY: -60,
            top: true,
            left: false,
          ),
        ],
        child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SafeArea(
                bottom: false,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  children: [
                    NewOfferListingForm(
                      routeData: widget.routeData,
                    ),
                  ],
                ))));
  }
}
