import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/utils/services/storage_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:provider/provider.dart';

import 'config/routes/routes.dart' as routes;
import 'config/routes/router.dart';
import 'config/themes/theme_config.dart';
import 'entities/commodity.dart';
import 'entities/listing.dart';
import 'entities/seller.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    child: App(),
  ));
}

class App extends StatefulWidget {
  _App createState() => _App();
}

class _App extends State<App> with WidgetsBindingObserver {
  AppState _appState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Event hook for when application state changes; close, active, resume...
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    return MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: fishappLightTheme,
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
  name: "bob",
  email: "bob@bob.com",
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
  price: 20,
);
