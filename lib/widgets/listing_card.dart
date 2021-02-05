import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/entities/listing.dart';
import 'package:***REMOVED***/widgets/rating_stars.dart';
import 'package:***REMOVED***/generated/l10n.dart';

class OfferListingCard extends StatelessWidget {
  final OfferListing cardListing;

  const OfferListingCard({Key key, this.cardListing}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Text(
            cardListing.creator.name,
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
                        cardListing.getDistanceTo().toString() + "Km",
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
                    cardListing.price.toString() + "kr/Kg",
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  Text(
                    cardListing.amountLeft.toString() + "Kg",
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