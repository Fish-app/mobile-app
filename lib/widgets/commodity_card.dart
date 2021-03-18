import 'package:cached_network_image/cached_network_image.dart';
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommodityCard extends StatelessWidget {
  final DisplayCommodity displayCommodity;

  const CommodityCard({Key key, this.displayCommodity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 190,
            width: double.infinity,
            child: Hero(
              tag:
                  "comodity-${displayCommodity.commodity.name}-${displayCommodity.commodity.id}",
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                margin: EdgeInsets.zero,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageUrl: displayCommodity.commodity.getImageUrl().toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(displayCommodity.commodity.name,
                    style: Theme.of(context).primaryTextTheme.headline1),
                Column(
                  children: [
                    Text(
                      S.of(context).from +
                          " ${displayCommodity.cheapestPrice} kr/kg",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                    Text(
                      S.of(context).from +
                          " ${displayCommodity.cheapestPrice} kr/kg",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
