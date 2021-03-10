import 'dart:ui';

import 'package:async/async.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/pages/home/search.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/widgets/buy_filter.dart';
import 'package:fishapp/widgets/commodity_card.dart';
import 'package:fishapp/widgets/listing_card.dart';
import 'package:fishapp/widgets/logo.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:fishapp/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/commodity.dart';
import '../../entities/listing.dart';
import '../../utils/services/rest_api_service.dart';
import '../../widgets/commodity_card.dart';

class HomePage extends StatefulWidget {
  final CommodityService _commodityService = CommodityService();

  @override
  State<StatefulWidget> createState() => HomePageState();
}

const double _topPadding = 25.0;
const double _bottomPadding = _topPadding + 10;

class HomePageState extends State<HomePage> {
  CancelableOperation<List<Commodity>> _future;

  @override
  void initState() {
    super.initState();
    _future = CancelableOperation.fromFuture(
        widget._commodityService.getAllCommodities(context));
  }

  @override
  void dispose() {
    _future.cancel();
    super.dispose();
  }

  Widget _makeComodityCard(Commodity commodity) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: true,
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) =>
              CommodityListingPage(
            listedCommodity: commodity,
          ),
        ))
      },
      child: CommodityCard(commodity: commodity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SearchState(),
        child: getFishappDefaultScaffold(context,
            useNavBar: navButtonShop,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _topPadding),
                  child: Logo(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: _topPadding, vertical: 20),
                  child: BuyFilterWidget(),
                ),
                appFutureBuilder<List<Commodity>>(_future.value,
                    (commodities, context) {
                  return Expanded(child: Consumer<SearchState>(
                    builder: (context, value, child) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: _bottomPadding),
                        children: commodities
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(
                                    value?.searchString?.toLowerCase() ?? ""))
                            .map((commodity) => _makeComodityCard(commodity))
                            .toList(),
                      );
                    },
                  ));
                })
              ],
            )));
  }
}

class CommodityListingPage extends StatefulWidget {
  final Commodity listedCommodity;
  final ListingService _listingService = ListingService();

  CommodityListingPage({Key key, this.listedCommodity}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommodityListingPageState();
}

class CommodityListingPageState extends State<CommodityListingPage>
    with TickerProviderStateMixin {
  CancelableOperation<List<OfferListing>> _future;

  @override
  void dispose() {
    _future.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _heightUsedInAnime = double.infinity;
      });
    });
    _future = CancelableOperation.fromFuture(widget._listingService
        .getCommodityOfferListing(context, widget.listedCommodity.id));
  }

  Widget _makeSortByWidget() {
    return Row(
      children: [],
    );
  }

  /*
   When tapping a listing card you get taken to the information
   page for that listing.
    */
  Widget _goToListing(OfferListing offerListing) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, routes.OfferListingInfo,
            arguments: offerListing)
      },
      child: OfferListingCard(cardListing: offerListing),
    );
  }

  double _heightUsedInAnime = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black12.withOpacity(0.2),
          ),
        ),
        ModalBarrier(
          dismissible: true,
          color: Colors.white.withOpacity(0),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                AnimatedSize(
                  vsync: this,
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    padding: EdgeInsets.only(top: 500),
                    height: _heightUsedInAnime,
                    width: MediaQuery.of(context).size.width -
                        (2 * (_bottomPadding + 30)),
                    color: Colors.white,
                  ),
                ),
                AnimatedSize(
                  vsync: this,
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    height: _heightUsedInAnime,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: _bottomPadding),
                      child: ListView(
                        children: [
                          _makeSortByWidget(),
                          appFutureBuilder<List<OfferListing>>(_future.value,
                              (offerListings, context) {
                            return Column(
                                children: offerListings
                                    .map((e) => _goToListing(e))
                                    .toList());
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(_bottomPadding, 0, _bottomPadding,
              MediaQuery.of(context).size.height / 1.53),
          child: CommodityCard(commodity: widget.listedCommodity),
        ),
      ],
      alignment: Alignment.bottomCenter,
    );
  }
}
