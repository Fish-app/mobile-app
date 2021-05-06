import 'package:async/async.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/subscription_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'design_misc.dart';

class SubscriptionStatus extends StatefulWidget {
  final _subService = SubscriptionService();

  SubscriptionStatus({Key key}) : super(key: key);

  @override
  _SubscriptionStatusState createState() => _SubscriptionStatusState();
}

class _SubscriptionStatusState extends State<SubscriptionStatus> {
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
    return appFutureBuilder<String>(
        future: _future.value,
        onSuccess: (status, context) {
          return DefaultCard(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                    children: [Text(status), _chooseCorrectIcon(status)],
                  )
                ],
              ),
            ],
          );
        });
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
