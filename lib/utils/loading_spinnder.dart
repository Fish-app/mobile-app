import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Container getCircularSpinner() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      children: [
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
        Text("Loading")
      ],
    ),
  );
}
