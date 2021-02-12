import 'package:flutter/cupertino.dart';
import 'package:maoyi/config/themes/theme_config.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Màoyi",
      style: TextStyle(
        fontFamily: "KaushanScript",
        fontSize: 70,
      ),
    );
  }
}
