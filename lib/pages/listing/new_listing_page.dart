import 'package:flutter/cupertino.dart';
import 'package:***REMOVED***/config/routes/route_data.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/pages/Listing/form_new_listing.dart';
import 'package:***REMOVED***/widgets/nav_widgets/common_nav.dart';

class NewListingPage extends StatefulWidget {
  final GenericRouteData routeData;
  NewListingPage({Key key, this.routeData}) : super(key: key);

  @override
  _NewListingPageState createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {
  @override
  Widget build(BuildContext context) {
    return get***REMOVED***DefaultScaffold(context,
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
                      NewListingForm(routeData: widget.routeData,),
                    ],
                  ))
          )
        ],
      )
    );
  }
}