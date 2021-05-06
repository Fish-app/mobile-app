import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'loading_spinnder.dart';

typedef OnSucBuild<T> = Widget Function(T futureValue, BuildContext context);

FutureBuilder<T> appFutureBuilder<T>(
    {@required Future<T> future,
    @required OnSucBuild<T> onSuccess,
    bool allowNull = false}) {
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
            return onSuccess(snapshot.data, context);
          } else {
            // todo:remove
            print("#####################################");
            print("Future builder error: ${snapshot.error}");
            print("Error name: ${snapshot.error.toString()}");
            print("Error type: ${snapshot.error.runtimeType}");
            print("#####################################");
            switch (snapshot.error.runtimeType) {
              case MissingRequiredKeysException:
                MissingRequiredKeysException a = snapshot.error;
                print("madlad switch error: ${a.message}");
            }
            return _showOnConError();
          }
      }
    },
  );
}

Widget _showOnConError() {
  return Center(
    child: Text(
      '< Connection error >',
      style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none),
    ),
  );
}
