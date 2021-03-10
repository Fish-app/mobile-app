import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:strings/strings.dart';

class NavigateToOfferListingButton extends StatelessWidget {
  final OfferListing offerListing;

  const NavigateToOfferListingButton({Key key, this.offerListing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(routes.OfferListingInfo, arguments: offerListing);
        },
        icon: Icon(Icons.description),
        label: Text(capitalize(S.of(context).view + " " + S.of(context).listing)));
  }
}

class NavigateToBuyRequestButton extends StatelessWidget {
  final BuyRequest buyRequest;

  const NavigateToBuyRequestButton({Key key, this.buyRequest})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(routes.BuyRequestInfo, arguments: buyRequest);
        },
        icon: Icon(Icons.description),
    label: Text(capitalize(S.of(context).view + " " + S.of(context).buyRequest)));
  }
}
