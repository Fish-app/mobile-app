import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/form/form_validators.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/Map/map_image.dart';
import 'package:fishapp/widgets/Map/open_map_widget.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/display_text_field.dart';
import 'package:fishapp/widgets/distance_to_widget.dart';
import 'package:fishapp/widgets/form/formfield_normal.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/rating_stars.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/rating_stars.dart';

class OfferListingInfoPage extends StatefulWidget {
  OfferListing offerListing;
  ReceiptService _receiptService = ReceiptService();

  _OfferListingInfoPageState createState() => _OfferListingInfoPageState();

  OfferListingInfoPage({Key key, @required this.offerListing})
      : super(key: key);
}

class _OfferListingInfoPageState extends State<OfferListingInfoPage> {
  final _formKey = GlobalKey<FormState>();
  var _chosenAmount;

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(
      context,
      extendBehindAppBar: true,
      includeTopBar: S.of(context).listing,
      child: Stack(
        children: [
          CircleThingy(
            sizeX: MediaQuery.of(context).size.width * 1.8,
            sizeY: MediaQuery.of(context).size.height * 1.4,
            centerX: -50,
            centerY: 0,
            left: false,
            top: false,
          ),
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.offerListing.creator.name,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4,
                                    ),
                                    UserRatingStars(
                                      user: widget.offerListing.creator,
                                    )
                                  ],
                                ),
                                DistanceToWidget(
                                  cardListing: widget.offerListing,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MapImage(
                                  height:
                                      MediaQuery.of(context).size.height / 2.2,
                                  latitude: widget.offerListing.latitude,
                                  longitude: widget.offerListing.longitude,
                                  onTap: (if_nothing_here_everything_breaks) {
                                    MapWidget(
                                            latitude:
                                                widget.offerListing.latitude,
                                            longitude:
                                                widget.offerListing.longitude)
                                        .openMapSheet(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                        elevation: Theme.of(context).cardTheme.elevation,
                        color: Theme.of(context).cardTheme.color,
                        shape: Theme.of(context).cardTheme.shape,
                        clipBehavior: Clip.none,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DisplayTextField(
                                  description:
                                      S.of(context).price.toUpperCase(),
                                  content:
                                      widget.offerListing.price.toString() +
                                          " kr/Kg"),
                              DisplayTextField(
                                  description: S
                                      .of(context)
                                      .quantityAvailable
                                      .toUpperCase(),
                                  content: widget.offerListing.amountLeft
                                          .toString() +
                                      " Kg"),
                              Consumer<AppState>(
                                builder: (context, userdata, child) {
                                  bool show = true;
                                  if (userdata.isLoggedIn()) {
                                    show = widget.offerListing.creator.id !=
                                        userdata.user.id;
                                  }
                                  return Visibility(
                                    visible: show,
                                    child: child,
                                  );
                                },
                                child: StandardButton(
                                  buttonText: "START CHAT",
                                  onPressed: () {
                                    print("Pressed");
                                    var _conversationService =
                                        ConversationService();
                                    _conversationService
                                        .startNewConversation(
                                            widget.offerListing.id)
                                        .then((value) =>
                                            //TESTING: fungerer OK: Er dette robust nok ?
                                            Navigator.of(context).pushNamed(
                                                routes.CHAT_CONVERSATIONS,
                                                arguments: value));
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: Form(
                                      key: _formKey,
                                      child: FormFieldNormal(
                                        title: S.of(context).amount,
                                        suffixText: "Kg",
                                        keyboardType: TextInputType.number,
                                        onSaved: (newValue) =>
                                            {_chosenAmount = newValue},
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return validateNotEmptyInput(
                                                value, context);
                                          } else {
                                            return validateIntInput(
                                                value, context);
                                          }
                                        },
                                      ),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 3.8,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10)),
                                  StandardButton(
                                    buttonText:
                                        S.of(context).buyDirectly.toUpperCase(),
                                    onPressed: () {
                                      FormState formState =
                                          _formKey.currentState;
                                      formState.save();
                                      if (formState.validate()) {
                                        widget._receiptService
                                            .newOrder(widget.offerListing.id,
                                                int.parse(_chosenAmount))
                                            .then((value) {
                                          if (value != null) {
                                            Navigator.pushNamed(
                                                context, routes.RECEIPT,
                                                arguments: value);
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
