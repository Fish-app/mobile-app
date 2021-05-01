import 'package:async/async.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/receipt.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/widgets/Map/open_map_widget.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/rating_stars.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class ReceiptListPage extends StatefulWidget {
  final ReceiptService _receiptService = ReceiptService();

  @override
  State<StatefulWidget> createState() => ReceiptListPageState();
}

class ReceiptListPageState extends State<ReceiptListPage> {
  CancelableOperation<List<Receipt>> _future;

  @override
  void initState() {
    super.initState();
    _future = CancelableOperation.fromFuture(
        widget._receiptService.getAllUserReceipt(context));
  }

  @override
  void dispose() {
    _future.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        includeTopBar: camelize(S.of(context).listReceipt),
        extendBehindAppBar: false,
        child: Stack(
          children: [
            // CircleThingy(
            //   sizeX: 400,
            //   sizeY: 300,
            //   centerX: 50,
            //   centerY: 300,
            //   top: true,
            //   left: false,
            // ),
            CircleThingy(
              sizeX: 500,
              sizeY: 700,
              centerX: 0,
              centerY: -60,
              top: false,
              left: true,
            ),
            appFutureBuilder<List<Receipt>>(
                future: _future.value,
                onSuccess: (receipts, context) {
                  return ListView(children: [
                    DefaultCard(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      children: [
                        Text(capitalize(S.of(context).clickViewReceipt)),
                        for (Receipt r in receipts) ...[
                          Divider(),
                          _ReceiptCard(
                            receipt: r,
                          ),
                        ]
                      ],
                    )
                  ]);
                }),
          ],
        ));
  }
}

class _ReceiptCard extends StatelessWidget {
  final Receipt receipt;

  const _ReceiptCard({Key key, this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, routes.RECEIPT, arguments: receipt),
      child: Container(
        color: Colors.black.withOpacity(0),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(capitalize(S.of(context).orderNr) + ": ${receipt.id}"),
                Text(S.of(context).commodity +
                    ": ${receipt.listing.commodity.name}")
              ],
            ),
            Spacer(),
            _RatedOrNotCheck(
              receipt: receipt,
            ),
          ],
        ),
      ),
    );
  }
}

class _RatedOrNotCheck extends StatefulWidget {
  final RatingService _ratingService = RatingService();
  final Receipt receipt;

  _RatedOrNotCheck({Key key, this.receipt}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RatedOrNotCheckState();
}

class _RatedOrNotCheckState extends State<_RatedOrNotCheck> {
  Future<num> _future;

  @override
  void initState() {
    super.initState();
    _future = widget._ratingService.getUserTransactionRating(widget.receipt.id);
  }

  @override
  Widget build(BuildContext context) {
    return appFutureBuilder<num>(
        future: _future,
        onSuccess: (num, context) {
          return Container(
            color: Colors.white,
            child: (num == -1)
                ? Text(
                    S.of(context).notRated.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.red),
                  )
                : Text(
                    S.of(context).rated.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.green),
                  ),
          );
        });
  }
}

class ReceiptPage extends StatefulWidget {
  final Receipt receipt;
  final RatingService _ratingService = RatingService();

  ReceiptPage({Key key, this.receipt}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  Future<num> _future;

  @override
  void initState() {
    super.initState();
    _future = widget._ratingService.getUserTransactionRating(widget.receipt.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final double _padding = 5.0;

  double _newRatingVal = 1;

  Widget ratingAria(int userRating) {
    if (userRating == -1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).notYetRated.toUpperCase() + ":",
            style: Theme.of(context).textTheme.overline,
          ),
          Slider(
            value: _newRatingVal,
            min: 0.0,
            max: 5.0,
            divisions: 5,
            label: capitalize(S.of(context).currentRating) +
                ": ${_newRatingVal.round()}",
            onChanged: (value) {
              setState(() {
                _newRatingVal = value;
              });
            },
          ),
          StandardButton(
              buttonText: capitalize(S.of(context).saveRating) + "?",
              onPressed: () => {
                    setState(() {
                      _future = widget._ratingService
                          .newRating(widget.receipt.id, _newRatingVal.floor());
                    })
                  })
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).rating.toUpperCase() + ":",
            style: Theme.of(context).textTheme.overline,
          ),
          RatingStars(rating: userRating.toDouble())
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        includeTopBar: capitalize(S.of(context).receiptFor) +
            " #${widget.receipt.id.round()}",
        extendBehindAppBar: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).commoditySold.toUpperCase() + ":",
                style: Theme.of(context).textTheme.overline,
              ),
              Text(
                "${widget.receipt.listing.commodity.name}",
                style: Theme.of(context).textTheme.headline4,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: appFutureBuilder<num>(
                    future: _future,
                    onSuccess: (ratingNumber, context) {
                      return ratingAria(ratingNumber);
                    }),
              ),

              /// --- Total --- ///
              Divider(
                thickness: Theme.of(context).dividerTheme.thickness,
                color: Theme.of(context).dividerTheme.color,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    _InfoValuePairDisplay(
                      info: capitalize(S.of(context).price),
                      value: "${widget.receipt.price.floor()}",
                      padding: EdgeInsets.symmetric(vertical: _padding),
                    ),
                    _InfoValuePairDisplay(
                      info: capitalize(S.of(context).amount) + ":",
                      value: "${widget.receipt.amount.floor()}",
                      padding: EdgeInsets.symmetric(vertical: _padding),
                    ),
                    _InfoValuePairDisplay(
                      info: capitalize(S.of(context).sum) + ":",
                      value:
                          "${(widget.receipt.amount * widget.receipt.price).floor()}",
                      padding: EdgeInsets.symmetric(vertical: _padding),
                    ),
                    _InfoValuePairDisplay(
                      info: capitalize(S.of(context).salesTax) + " 15%:",
                      value:
                          "${(widget.receipt.price * widget.receipt.amount * 0.15).floor()}",
                      padding: EdgeInsets.fromLTRB(0, _padding, 0, 0),
                    ),
                    Divider(
                      thickness: Theme.of(context).dividerTheme.thickness,
                      color: Theme.of(context).dividerTheme.color,
                    ),
                    _InfoValuePairDisplay(
                      info: capitalize(S.of(context).total) + ":",
                      value:
                          "${(widget.receipt.price * widget.receipt.amount * 1.15).floor()}",
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ),
              ),

              /// --- seller --- ///
              Divider(
                thickness: Theme.of(context).dividerTheme.thickness,
                color: Theme.of(context).dividerTheme.color,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: Text(
                  S.of(context).seller.toUpperCase(),
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              Text(
                "${widget.receipt.seller.name}",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                S.of(context).regNumber +
                    ": ${widget.receipt.seller.regNumber}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                S.of(context).additionalInfo + ":",
                style: Theme.of(context).textTheme.bodyText2,
              ),

              /// --- buyer --- ///

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                child: Text(
                  S.of(context).buyer.toUpperCase(),
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              Text(
                "${widget.receipt.buyer.name}",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 5,
              ),

              Text(
                S.of(context).additionalInfo + ":",
                style: Theme.of(context).textTheme.bodyText2,
              ),

              /// --- pickup info --- ///

              Divider(
                thickness: Theme.of(context).dividerTheme.thickness,
                color: Theme.of(context).dividerTheme.color,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: Text(
                  S.of(context).pickupDate.toUpperCase() + ":",
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              Text(
                "${DateTime.fromMillisecondsSinceEpoch((widget.receipt.created * 1000).floor())}"
                    .substring(0, 10),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Divider(
                thickness: Theme.of(context).dividerTheme.thickness,
                color: Theme.of(context).dividerTheme.color,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: Text(
                  S.of(context).pickupLocation.toUpperCase() + ":",
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "lat: ${widget.receipt.listing.latitude}",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "lng: ${widget.receipt.listing.longitude}",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  StandardButton(
                      buttonText: S.of(context).goToMap.toUpperCase(),
                      onPressed: () {
                        MapWidget(
                                latitude: widget.receipt.listing.latitude,
                                longitude: widget.receipt.listing.longitude)
                            .openMapSheet(context);
                      })
                ],
              )
            ],
          ),
        ));
  }
}

class _InfoValuePairDisplay extends StatelessWidget {
  final String info;
  final String value;
  final EdgeInsets padding;

  const _InfoValuePairDisplay(
      {Key key, this.info, this.value, this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$info",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            "$value",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
