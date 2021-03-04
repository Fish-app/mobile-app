import 'package:flutter/cupertino.dart';
import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/pages/listing/form_new_offer_listing.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';

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
      includeTopBar: S.of(context).newOfferListing,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
              child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    children: [
                      NewOfferListingForm(routeData: widget.routeData,),
                    ],
                  ))
          )
        ],
      )
    );
  }
}