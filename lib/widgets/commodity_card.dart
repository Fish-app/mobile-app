import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/themes/theme_config.dart';
import 'package:***REMOVED***/entities/commodity.dart';

class CommodityCard extends StatelessWidget {
  final Commodity commodity;

  const CommodityCard({Key key, this.commodity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: commodity.name,
      child: Card(
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                fit: BoxFit.cover,
                image: commodity.getImage().image,
              ),
              Align(
                alignment: Alignment(1.1, 1.1),
                child: Container(
                  height: 80, // height of the blured box
                  width: 170, // with of the blured box
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(appBorderRadius))),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.white.withOpacity(0.3)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              commodity.name,
                              style:
                                  Theme.of(context).primaryTextTheme.headline3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "fra X kr/kg",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline5,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
