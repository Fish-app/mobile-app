import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class NavigateToListingButton extends StatelessWidget {
  final Listing listing;

  Future<Listing> _future;

  NavigateToListingButton({Key key, this.listing}) : super(key: key) {
    print(listing.listingType);
    switch (listing.listingType) {
      case ListingTypes.Offer:
        _future = ListingService().getOfferListing(listing.id);
        break;
      case ListingTypes.Request:
        _future = ListingService().getBuyRequest(listing.id);
        break;
    }
  }

  void _navigate(BuildContext context, Listing listing) {
    if (listing is OfferListing) {
      print("aaa");
      Navigator.of(context)
          .pushNamed(routes.OFFER_LISTING_INFO, arguments: listing);
    } else if (listing is BuyRequest) {
      print("bbb");
      Navigator.of(context)
          .pushNamed(routes.BUY_REQUEST_INFO, arguments: listing);
    }
  }

  @override
  Widget build(BuildContext context) {
    return appFutureBuilder(
      future: _future,
      onSuccess: (futureValue, context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton.icon(
              onPressed: () {
                _navigate(context, futureValue);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => emphasisColor),
              ),
              icon: Icon(Icons.description, color: emphasisButton),
              label: Text(
                  capitalize(S.of(context).view + " " + S.of(context).listing),
                  style: TextStyle(color: emphasisButton))),
        );
      },
    );
  }
}
