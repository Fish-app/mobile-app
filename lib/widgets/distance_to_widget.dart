import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/entities/listing.dart';

class DistanceToWidget extends StatefulWidget {
  final Listing cardListing;

  const DistanceToWidget({Key key, this.cardListing}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DistanceToWidgetState();
}

class _DistanceToWidgetState extends State<DistanceToWidget> {
  var _distance = 0.0;
  CancelableOperation _future;

  @override
  void initState() {
    super.initState();
    _future = CancelableOperation.fromFuture(widget.cardListing.getDistanceTo())
        .then((value) {
      setState(() {
        _distance = value;
      });
    });
  }

  @override
  void dispose() {
    _future.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on),
        Text(
          _distance.toString() + "Km",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
      ],
    );
  }
}
