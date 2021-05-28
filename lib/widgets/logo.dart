import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Align(
          widthFactor: 2,
          heightFactor: 1,
          alignment: FractionalOffset(0, 0),
          child: Text(
            "Fishapp",
            style: TextStyle(
              fontFamily: "KaushanScript",
              fontSize: 80,
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.86, 1),
          heightFactor: 3.7,
          child: Text(
            "Buy fresh seafood",
            style: TextStyle(
              fontFamily: "Dosis",
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }
}
