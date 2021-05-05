import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/payment_webview.dart';
import 'package:fishapp/utils/services/subscription_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/subscription_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

class SubscriptionInfoPage extends StatefulWidget {
  final GenericRouteData routeData;
  final _subService = SubscriptionService();
  var _isSubscribed = false;

  SubscriptionInfoPage({Key key, this.routeData}) : super(key: key);

  @override
  _SubscriptionInfoPageState createState() => _SubscriptionInfoPageState();
}

class _SubscriptionInfoPageState extends State<SubscriptionInfoPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getIsSubscriptionValid();
    return getFishappDefaultScaffold(context,
        extendBehindAppBar: false,
        includeTopBar: capitalize(S.of(context).subscriptionInfo),
        bgDecor: [
          CircleThingy(
            sizeX: MediaQuery.of(context).size.width * 2,
            sizeY: MediaQuery.of(context).size.width * 1.5,
            centerX: -20,
            centerY: 200,
            left: true,
            top: false,
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [SubscriptionStatus(), _displaySubscriptionButton()],
          ),
        ));
  }

  void _getIsSubscriptionValid() async {
    User user = Provider.of<AppState>(context, listen: false)?.user;
    bool isValid = await widget._subService.getIsSubscriptionValid(user.id);
    setState(() {
      widget._isSubscribed = isValid;
    });
  }

  Widget _displaySubscriptionButton() {
    if (widget._isSubscribed) {
      return ButtonV2(
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: () {
          widget._subService.cancelSubscription();
        },
        buttonText: camelize(S.of(context).cancelSubscription),
        buttonIcon: Icons.cancel_presentation_outlined,
      );
    } else {
      return ButtonV2(
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: () {
          var a = new SubscriptionService();
          a.getNewSubscription().then((value) {
            print(value.hostedPaymentPageUrl);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentWebview(
                    killUrl: "http://foo.bar",
                    startUrl: value.hostedPaymentPageUrl,
                  ),
                ));
          });
        },
        buttonText: capitalize(S.of(context).subscribe),
        buttonIcon: Icons.assignment_turned_in,
      );
    }
  }
}
