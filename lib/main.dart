import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:***REMOVED***/entities/user.dart';

import 'config/routes/routes.dart' as routes;
import 'config/routes/router.dart';
import 'config/themes/theme_config.dart';
import 'entities/commodity.dart';
import 'entities/listing.dart';
import 'widgets/floating_nav_bar.dart';
import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ***REMOVED***LightTheme,
        title: 'Flutter Demo',
        initialRoute: routes.UserLogin,
        onGenerateRoute: (settings) => router(context, settings));
  }
}

/// -- test data -- ///
var testCommodity = Commodity(commodityImage: null, name: "ALLLA");
var testCommodity2 = Commodity(commodityImage: null, name: "lakdsfjlk");
var testCommodity3 = Commodity(commodityImage: null, name: "lelele");
var testSeller = Seller(
    name: "bob",
    bankAccountNumber: "123",
    email: "bip@bop.com",
    id: 22,
    regNumber: "2312",
    rating: 3.6,
    );
var testOfferListing = OfferListing(
    id: 111,
    maxAmount: 22,
    amountLeft: 22,
    commodity: testCommodity,
    creator: testSeller,
    isOpen: true,
    price: 20);
