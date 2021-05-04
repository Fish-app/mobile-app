import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/pages/home/search.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/payment_webview.dart';
import 'package:fishapp/utils/services/subscription_service.dart';
import 'package:fishapp/widgets/buy_filter.dart';
import 'package:fishapp/widgets/commodity_card.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/logo.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/commodity.dart';
import '../../utils/services/rest_api_service.dart';
import '../../widgets/commodity_card.dart';

const double _topPadding = 25.0;
const double _bottomPadding = _topPadding + 10;

class HomePage extends StatelessWidget {
  final Future<List<DisplayCommodity>> _future =
      CommodityService().getAllDisplayCommodities();

  Widget _makeCommodityCard(DisplayCommodity commodity, BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context)
            .pushNamed(routes.COMMODITY_LISTING_PAGE, arguments: commodity)
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CommodityCard(displayCommodity: commodity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SearchState(),
        child: getFishappDefaultScaffold(context,
            useNavBar: navButtonShop,
            child: Stack(
              children: [
                CircleThingy(
                  sizeX: 1100,
                  sizeY: 800,
                  centerX: 0,
                  centerY: -50,
                  top: true,
                  left: true,
                ),
                ListView(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: _topPadding),
                      child: Logo(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: _topPadding, vertical: 20),
                      child: BuyFilterWidget(),
                    ),
                    StandardButton(
                      buttonText: "webtest",
                      onPressed: () {
                        var a = new SubscriptionService();
                        a.getNewSubscription().then((value) {
                          print(value.hostedPaymentPageUrl);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentWebview(
                                  killUrl: "",
                                  startUrl: value.hostedPaymentPageUrl,
                                ),
                              ));
                        });
                      },
                    ),
                    appFutureBuilder<List<DisplayCommodity>>(
                        future: _future,
                        onSuccess: (commodities, context) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: _bottomPadding),
                              child: Consumer<SearchState>(
                                builder: (context, value, child) {
                                  return Column(
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: _bottomPadding),
                                    children: commodities
                                        .where((element) => element
                                            .commodity.name
                                            .toLowerCase()
                                            .contains(value?.searchString
                                                    ?.toLowerCase() ??
                                                ""))
                                        .map((commodity) => _makeCommodityCard(
                                            commodity, context))
                                        .toList(),
                                  );
                                },
                              ));
                        })
                  ],
                ),
              ],
            )));
  }
}
