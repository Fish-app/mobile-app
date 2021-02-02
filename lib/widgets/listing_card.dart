import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/themes/theme_config.dart';
import 'package:***REMOVED***/entities/listing.dart';
import 'package:***REMOVED***/widgets/simple_icon_shadow_widget.dart';
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
                    S.of(context).pris,
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  Text(
                    S.of(context).tilgjengelighet,
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

/// -- stars --- ///
final _fullStar = SimpleShadowWidget(
  iconData: Icons.star,
  size: ratingStarTheme.size,
  iconColor: ratingStarTheme.color,
  blur: 1,
);
final _halfStar = SimpleShadowWidget(
  iconData: Icons.star_half,
  size: ratingStarTheme.size,
  iconColor: ratingStarTheme.color,
  blur: 1,
);
final _emptyStar = SimpleShadowWidget(
  iconData: Icons.star_border,
  size: ratingStarTheme.size,
  iconColor: ratingStarTheme.color,
  blur: 1,
);

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({Key key, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmp = rating;
    List<Widget> stars = [];
    for (var n = 0; n < 5; n++) {
      if (tmp >= 1) {
        stars.add(_fullStar);
        tmp--;
      } else if (tmp >= 0.5) {
        stars.add(_halfStar);
        tmp -= 0.5;
      } else {
        stars.add(_emptyStar);
      }
    }

    return Row(
      children: stars,
    );
  }
}
