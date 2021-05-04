import 'package:async/async.dart';
import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/subscription_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

class SubscriptionInfoPage extends StatefulWidget {
  final GenericRouteData routeData;
  final _subService = SubscriptionService();

  SubscriptionInfoPage({Key key, this.routeData}) : super(key: key);

  @override
  _SubscriptionInfoPageState createState() => _SubscriptionInfoPageState();
}

class _SubscriptionInfoPageState extends State<SubscriptionInfoPage> {
  CancelableOperation<String> _future;

  @override
  void initState() {
    super.initState();
    _future = CancelableOperation.fromFuture(widget._subService
        .getSubscriptionStatus(
            Provider.of<AppState>(context, listen: false)?.user?.id));
  }

  @override
  void dispose() {
    _future.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(
      context,
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
      child: appFutureBuilder<String>(
          future: _future.value,
          onSuccess: (status, context) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: [
                  DefaultCard(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).subscriptionStatus.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(status),
                              _chooseCorrectIcon(status)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  ButtonV2(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      widget._subService.cancelSubscription();
                    },
                    buttonText: camelize(S.of(context).cancelSubscription),
                    buttonIcon: Icons.cancel_presentation_outlined,
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget _chooseCorrectIcon(String status) {
    switch (status) {
      case "\"OK\"":
        return Icon(Icons.check_circle_outline, color: Colors.green);
        break;
      case "\"NOT_ACTIVE\"":
        return Icon(Icons.cancel_outlined, color: Colors.red);
        break;
      case "\"PAY_ERROR\"":
        return Icon(Icons.error_outline, color: Colors.red);
        break;
      case "\"PENDING\"":
        return Icon(Icons.details_outlined, color: Colors.yellow);
        break;
      default:
        return Icon(
          Icons.error,
          color: Colors.blue,
        );
    }
  }
}
