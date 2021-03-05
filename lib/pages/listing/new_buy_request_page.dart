import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/pages/listing/form_new_buy_request.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/cupertino.dart';

class NewBuyRequestPage extends StatelessWidget {
  final GenericRouteData routeData;
  NewBuyRequestPage({this.routeData});

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
      includeTopBar: S.of(context).newBuyRequest,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  NewBuyRequestForm(routeData: routeData,)
                ],
              ),
            ),
          )
        ],
      )
    );
  }

}