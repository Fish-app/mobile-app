import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/entities/commodity.dart';
import 'package:***REMOVED***/entities/listing.dart';
import 'package:***REMOVED***/main.dart';
import 'package:***REMOVED***/pages/listing_info_page.dart';
import 'package:***REMOVED***/widgets/buy_filter.dart';
import 'package:***REMOVED***/widgets/commodity_card.dart';
import 'package:***REMOVED***/widgets/floating_nav_bar.dart';
import 'package:***REMOVED***/widgets/listing_card.dart';
import 'package:***REMOVED***/widgets/logo.dart';
import 'package:***REMOVED***/widgets/nav_widgets/common_nav.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

const double _topPadding = 25.0;
const double _bottomPadding = _topPadding + 10;

class HomePageState extends State<HomePage> {
  void _onTapComodity(Commodity commodity) {}

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
    return get***REMOVED***DefaultScaffold(context,
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
              padding: const EdgeInsets.symmetric(horizontal: _topPadding),
              child: BuyFilterWidget(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: _bottomPadding),
                children: [
                  _makeComodityCard(testCommodity),
                  _makeComodityCard(testCommodity2),
                  _makeComodityCard(testCommodity3)
                ],
              ),
            )
          ],
        ));
  }
}

class CommodityListingPage extends StatefulWidget {
  final Commodity listedCommodity;

  const CommodityListingPage({Key key, this.listedCommodity}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommodityListingPageState();
}

class CommodityListingPageState extends State<CommodityListingPage>
    with TickerProviderStateMixin {
  List<Widget> _listings = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _heightUsedInAnime = double.infinity;
      });
    });
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListingInfoPage(offerListing: offerListing),
          ),
        ),
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
                          for (var n = 0; n < 10; n++)
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: _goToListing(testOfferListing)),
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
