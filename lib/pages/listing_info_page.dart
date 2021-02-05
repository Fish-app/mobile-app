
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maoyi/entities/listing.dart';
import 'package:maoyi/widgets/floating_nav_bar.dart';
import 'package:maoyi/widgets/rating_stars.dart';

class ListingInfoPage extends StatelessWidget {
  final OfferListing offerListing;

  const ListingInfoPage({Key key, this.offerListing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: Theme.of(context).cardTheme.elevation,
                  color: Theme.of(context).cardTheme.color,
                  shape: Theme.of(context).cardTheme.shape,
                  clipBehavior: Clip.none,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offerListing.creator.name,
                                style: Theme.of(context).primaryTextTheme.headline4,
                              ),
                              RatingStars(
                                rating: offerListing.creator.rating,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                //crossAxisAlignment: CrossAxisAlignment.end,
                               // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on),
                                  Text(
                                    offerListing.getDistanceTo().toString() + "Km",
                                    style: Theme.of(context).primaryTextTheme.headline6,
                                  )
                                ],
                              )
                            ],
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MaoyiNavBar(
              currentActiveButton: navButtonShop,
            ),
          )
        ],
      ),
    );
  }
}