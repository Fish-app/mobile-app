
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maoyi/entities/listing.dart';
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/widgets/display_text_field.dart';
import 'package:maoyi/widgets/floating_nav_bar.dart';
import 'package:maoyi/widgets/rating_stars.dart';
import 'package:maoyi/widgets/standard_button.dart';

class ListingInfoPage extends StatelessWidget {
  final OfferListing offerListing;

  const ListingInfoPage({Key key, this.offerListing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //TODO: Skjekk om det kan gjøres med theme
      appBar: AppBar(
        //TODO: Theme driten funke ikkje
        elevation: Theme.of(context).appBarTheme.elevation,
        title: Text(
          S.of(context).listing,
          style: Theme.of(context).primaryTextTheme.headline4,
        ),
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: Column(
              children: [
                Card(
                  elevation: Theme.of(context).cardTheme.elevation,
                  color: Theme.of(context).cardTheme.color,
                  shape: Theme.of(context).cardTheme.shape,
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
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
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on),
                                    Text(
                                      offerListing.getDistanceTo().toString() + "Km",
                                      style: Theme.of(context).primaryTextTheme.headline6,
                                    )
                                  ],
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 200,
                          ),
                          Text(
                            "KART"
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: Theme.of(context).cardTheme.elevation,
                  color: Theme.of(context).cardTheme.color,
                  shape: Theme.of(context).cardTheme.shape,
                  clipBehavior: Clip.none,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayTextField(
                          description: S.of(context).price.toUpperCase(),
                          content: offerListing.price.toString() + " kr/Kg"
                        ),
                        DisplayTextField(
                            description: S.of(context).quantityAvailable.toUpperCase(),
                            content: offerListing.amountLeft.toString() + " Kg"
                        ),
                        StandardButton(
                          buttonText: "START CHAT",
                          onPressed: () {
                            print("Pressed");
                          }, //TODO: legg til åpning av chat
                        ),
                        StandardButton(
                          buttonText: S.of(context).buyDirectly.toUpperCase(),
                          onPressed: () {
                            print("Pressed2");
                          }, //TODO: legg til direkte kjøp
                        )
                      ],
                    ),
                  )
                )
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


