import 'package:flutter/cupertino.dart';
import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/pages/listing/form_new_listing.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';

class NewListingPage extends StatefulWidget {
  final GenericRouteData routeData;
  NewListingPage({Key key, this.routeData}) : super(key: key);

  @override
  _NewListingPageState createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {
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
                      NewListingForm(routeData: widget.routeData,),
                    ],
                  ))
          )
        ],
      )
    );
  }
}