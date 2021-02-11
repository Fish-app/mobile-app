import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/utils/services/secure_storage.dart';

import 'config/routes/routes.dart' as routes;
import 'config/routes/router.dart';
import 'config/themes/theme_config.dart';
import 'entities/commodity.dart';
import 'entities/listing.dart';
import 'entities/seller.dart';
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
        initialRoute: routes.Home,
        onGenerateRoute: (settings) => router(context, settings));
  }
}

/// -- test data -- ///
var testCommodity = Commodity(commodityImage: null, name: "ALLLA");
var testCommodity2 = Commodity(commodityImage: null, name: "lakdsfjlk");
var testCommodity3 = Commodity(commodityImage: null, name: "lelele");
var testUserBob = User(
  id: 22,
  name: "bob",
  email: "bob@bob.com",
);
var testSellerBob = Seller(
    id: 22,
    user: testUserBob,
    regNumber: "2312",
    rating: 3.6,
    );
var testOfferListing = OfferListing(
    id: 111,
    maxAmount: 22,
    amountLeft: 22,
    commodity: testCommodity,
    creator: testSellerBob,
    isOpen: true,
    latitude: 69.224890,
    longitude: 18.303778,
    price: 20,);
