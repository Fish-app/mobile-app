import 'dart:ui';

import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/widgets/distance_to_widget.dart';
import 'package:fishapp/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

import 'rating_stars.dart';

class ListingCard extends StatelessWidget {
  final Listing cardListing;

  const ListingCard({Key key, this.cardListing}) : super(key: key);

  final double _spaceBetweenRows = 10;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardListing.creator.name,
              style: Theme.of(context).primaryTextTheme.headline5,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserRatingStars(user: cardListing.creator),
                    SizedBox(
                      height: _spaceBetweenRows,
                    ),
                    DistanceToWidget(cardListing: cardListing),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).price,
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                    SizedBox(
                      height: _spaceBetweenRows,
                    ),
                    Text(
                      S.of(context).availability,
                      style: Theme.of(context).primaryTextTheme.headline6,
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardListing.price.toString() + "kr/Kg",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                    SizedBox(
                      height: _spaceBetweenRows,
                    ),
                    Text(
                      cardListing.price.toString() + "kr/Kg",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                    // Text(
                    //   cardListing.amountLeft.toString() + "Kg",
                    //   style: Theme.of(context).primaryTextTheme.headline6,
                    // )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
