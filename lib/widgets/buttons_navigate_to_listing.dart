import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class NavigateToListingButton extends StatelessWidget {
  final Listing conv_listing;

  Future<Listing> _future;

  NavigateToListingButton({Key key, this.conv_listing}) : super(key: key) {
    print(conv_listing.listingType);
    switch (conv_listing.listingType) {
      case ListingTypes.Offer:
        _future = ListingService().getOfferListing(conv_listing.id);
        break;
      case ListingTypes.Request:
        _future = ListingService().getBuyRequest(conv_listing.id);
        break;
    }
  }

  void _navigate(BuildContext context, Listing listing) {
    if (listing is OfferListing) {
      print("aaa");
      Navigator.of(context)
          .pushNamed(routes.OfferListingInfo, arguments: listing);
    } else if (listing is BuyRequest) {
      print("bbb");
      Navigator.of(context)
          .pushNamed(routes.BuyRequestInfo, arguments: listing);
    }
  }

  @override
  Widget build(BuildContext context) {
    return appFutureBuilder(
      future: _future,
      onSuccess: (futureValue, context) {
        return TextButton.icon(
            onPressed: () {
              _navigate(context, futureValue);
            },
            icon: Icon(Icons.description, color: emphasisColor),
            label: Text(
                capitalize(S.of(context).view + " " + S.of(context).listing),
                style: TextStyle(color: emphasisColor)));
      },
    );
  }
}
