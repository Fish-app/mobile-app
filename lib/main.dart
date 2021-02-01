import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maoyi/entities/user.dart';

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
        //theme: maoyiLightTheme,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: routes.Home,
        onGenerateRoute: (settings) => router(context, settings));
  }
}
