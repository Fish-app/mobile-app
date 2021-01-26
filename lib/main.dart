import 'package:flutter/material.dart';

import 'config/routes/routes.dart' as routes;
import 'config/routes/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: routes.Home,
        onGenerateRoute: (settings) => router(context, settings));
  }
}
