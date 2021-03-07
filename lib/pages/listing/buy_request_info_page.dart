import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/widgets/Map/map_image.dart';
import 'package:fishapp/widgets/Map/open_map_widget.dart';
import 'package:fishapp/widgets/display_text_field.dart';
import 'package:fishapp/widgets/distance_to_widget.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/rating_stars.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fishapp/config/routes/routes.dart' as routes;

class BuyRequestInfoPage extends StatelessWidget {
  BuyRequest buyRequest;

  BuyRequestInfoPage({Key key, this.buyRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(
        context,
        extendBehindAppBar: false,
        includeTopBar: S.of(context).buyRequest,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
          child: ListView(
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
                                  buyRequest.creator.name,
                                  style:
                                  Theme.of(context).primaryTextTheme.headline4,
                                ),
                                UserRatingStars(
                                  user: buyRequest.creator,
                                )
                              ],
                            ),
                            DistanceToWidget(
                              cardListing: buyRequest,
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MapImage(
                              height: MediaQuery.of(context).size.height / 2.2,
                              latitude: buyRequest.latitude,
                              longitude: buyRequest.longitude,
                              onTap: (if_nothing_here_everything_breaks) {
                                MapWidget(
                                    latitude: buyRequest.latitude,
                                    longitude: buyRequest.longitude)
                                    .openMapSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
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
                            description:
                            S.of(context).amount.toUpperCase(),
                            content: buyRequest.amount.toString() + " Kg"),
                        DisplayTextField(
                            description: S.of(context).price.toUpperCase(),
                            content: buyRequest.price.toString() + " kr/Kg"),
                        DisplayTextField(
                            description: S.of(context).dueDate.toUpperCase(),
                            content: DateTime.fromMillisecondsSinceEpoch(
                                buyRequest.endDate).toString().substring(0,10)),
                        DisplayTextField(
                            description: S.of(context).maxDistance,
                            content: buyRequest.maxDistance.toString() + " Km"),
                        StandardButton(
                          buttonText: "START CHAT",
                          onPressed: () {
                            print("Pressed");
                            var _conversationService = ConversationService();
                            _conversationService.
                            startNewConversation(context, buyRequest.id).then((value) =>
                            //TESTING: fungerer OK: Er dette robust nok ?
                            Navigator.of(context).pushNamed(
                                routes.ChatConversation,
                                arguments: value)
                            );
                          },
                        ),
                        StandardButton(
                          buttonText: S.of(context).takeBuyRequest.toUpperCase(),
                          onPressed: () {
                            print("Pressed2");
                          }, //TODO: legg til direkte kjøp
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )
    );
  }
}