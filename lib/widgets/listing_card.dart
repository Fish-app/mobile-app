import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maoyi/entities/listing.dart';
import 'package:maoyi/widgets/rating_stars.dart';
import 'package:maoyi/generated/l10n.dart';

class OfferListingCard extends StatefulWidget {
  final OfferListing cardListing;

  const OfferListingCard({Key key, this.cardListing}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OfferListingCardState();
}

class OfferListingCardState extends State<OfferListingCard> {
  var _distance = 0.0;

  @override
  void initState() {
    super.initState();
    widget.cardListing.getDistanceTo().then((value) {
      setState(() {
        _distance = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Text(
            widget.cardListing.creator.user.name,
            style: Theme.of(context).primaryTextTheme.headline5,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingStars(
                    rating: 4.8,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        _distance.toString() + "Km",
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).price,
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  Text(
                    S.of(context).availability,
                    style: Theme.of(context).primaryTextTheme.headline6,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cardListing.price.toString() + "kr/Kg",
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  Text(
                    widget.cardListing.amountLeft.toString() + "Kg",
                    style: Theme.of(context).primaryTextTheme.headline6,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}