import 'package:flutter/cupertino.dart';
import 'package:maoyi/config/routes/route_data.dart';
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/pages/Listing/form_new_listing.dart';
import 'package:maoyi/widgets/nav_widgets/common_nav.dart';

class NewListingPage extends StatefulWidget {
  final GenericRouteData routeData;
  NewListingPage({Key key, this.routeData}) : super(key: key);

  @override
  _NewListingPageState createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {
  @override
  Widget build(BuildContext context) {
    return getMaoyiDefaultScaffold(context,
      includeTopBar: S.of(context).newListing,
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