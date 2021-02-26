import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/routes/route_data.dart';
import 'package:***REMOVED***/entities/listing.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/main.dart';
import 'package:***REMOVED***/widgets/Map/map_image.dart';
import 'package:***REMOVED***/widgets/Map/open_map_widget.dart';
import 'package:***REMOVED***/widgets/display_text_field.dart';
import 'package:***REMOVED***/widgets/distance_to_widget.dart';
import 'package:***REMOVED***/widgets/nav_widgets/common_nav.dart';
import 'package:***REMOVED***/widgets/rating_stars.dart';
import 'package:***REMOVED***/widgets/standard_button.dart';


class ListingInfoPage extends StatelessWidget {
  final LoginReturnRouteData routeData;
  OfferListing offerListing;

  ListingInfoPage({Key key, this.routeData, this.offerListing}) : super(key: key) {
    //TODO: must be changed to be able to show listing from server
    this.offerListing = testOfferListing;
  }

  @override
  Widget build(BuildContext context) {
    return get***REMOVED***DefaultScaffold(
      context,
      includeTopBar: S.of(context).listing,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 85.0, 10.0, 10.0),
        child: Column(
          children: [
            Card(
              elevation: Theme.of(context).cardTheme.elevation,
              color: Theme.of(context).cardTheme.color,
              shape: Theme.of(context).cardTheme.shape,
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offerListing.creator.name,
                              style:
                                  Theme.of(context).primaryTextTheme.headline4,
                            ),
                            RatingStars(
                              rating: offerListing.creator.rating,
                            )
                          ],
                        ),
                        DistanceToWidget(
                          cardListing: offerListing,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MapImage(
                          height: MediaQuery.of(context).size.height / 2.2,
                          latitude: offerListing.latitude,
                          longitude: offerListing.longitude,
                          onTap: (abc) {
                            MapWidget(
                                latitude: offerListing.latitude,
                                longitude: offerListing.longitude).openMapSheet(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
                elevation: Theme.of(context).cardTheme.elevation,
                color: Theme.of(context).cardTheme.color,
                shape: Theme.of(context).cardTheme.shape,
                clipBehavior: Clip.none,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DisplayTextField(
                          description: S.of(context).price.toUpperCase(),
                          content: offerListing.price.toString() + " kr/Kg"),
                      DisplayTextField(
                          description:
                              S.of(context).quantityAvailable.toUpperCase(),
                          content: offerListing.amountLeft.toString() + " Kg"),
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
                ))
          ],
        ),
      ),
    );
  }
}