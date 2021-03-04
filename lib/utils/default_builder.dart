import 'package:flutter/material.dart';

import 'loading_spinnder.dart';

typedef OnSucBuild<T> = Widget Function(T, BuildContext);

FutureBuilder<T> appFutureBuilder<T>(Future<T> future, OnSucBuild<T> onSucses,
    {bool allowNull = false}) {
  return FutureBuilder(
    future: future,
    builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
      switch (snapshot.connectionState) {
        // if not started or waiting show loading
        case ConnectionState.none:
        case ConnectionState.waiting:
          return getCircularSpinner();
          break;
        //case ConnectionState.active:
        //case ConnectionState.done:
        default:
          if (!snapshot.hasError) {
            if (!allowNull && snapshot.data == null) {
              return _showOnConError();
            }
            return onSucses(snapshot.data, context);
          } else {
            // todo:remove
            print("Future builder error: ${snapshot.error}");
            return _showOnConError();
          }
      }
    },
  );
}

Widget _showOnConError() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('ERROR:'),
      )
    ],
  );
}
