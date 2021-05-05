import 'package:cached_network_image/cached_network_image.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/utils/default_builder.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/utils/state/appstate.dart';
import 'package:fishapp/widgets/listing_card.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double _topPadding = 25.0;
const double _bottomPadding = _topPadding + 10;

class CommodityListingPage extends StatefulWidget {
  final DisplayCommodity displayCommodity;
  final ListingService _listingService = ListingService();

  CommodityListingPage({Key key, this.displayCommodity}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommodityListingPageState();
}

class CommodityListingPageState extends State<CommodityListingPage>
    with TickerProviderStateMixin {
  Future<List<OfferListing>> _future;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _animeTopPos = _imageHeight - (appBorderRadius * 2);
      });
    });
    if (Provider.of<AppState>(context, listen: false).isSeller()) {
      _future = widget._listingService
          //TODO:fortsjett her
          .getCommodityOfferListing(widget.displayCommodity.commodity.id);
    }
    _future = widget._listingService
        .getCommodityOfferListing(widget.displayCommodity.commodity.id);
  }

  final double _imageHeight = 300;

  double _animeTopPos = -1;

  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        includeTopBar: "",
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // AnimatedPositioned(
                //   width: MediaQuery.of(context).size.width,
                //   top: _animeTopPos,
                //   duration: const Duration(milliseconds: 300),
                //   child:
                Container(
                  padding: EdgeInsets.only(
                      top: _imageHeight - (appBorderRadius * 2)),
                  child: Card(
                    color: emphasisColor,
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.displayCommodity.commodity.name,
                              style:
                                  Theme.of(context).primaryTextTheme.headline1),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Atlanterhavslaksen blir av mange holdt for å være den flotteste av lakseartene. Hannlaksen (som gjerne kalles hake) kan trolig bli opptil 1,5 m lang og veie mer enn 40 kg. Hunnlaksen blir noe mindre. Den offisielle verdensrekorden for stangfiske er en laks som veide 32,5kg.",
                              style: Theme.of(context).textTheme.bodyText2),
                        ],
                      ),
                    ),
                  ),
                ),
                // ),
                SizedBox(
                  height: _imageHeight,
                  width: double.infinity,
                  child: Hero(
                    tag:
                        "commodity-${widget.displayCommodity.commodity.name}-${widget.displayCommodity.commodity.id}",
                    child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(appBorderRadius),
                        bottomRight: Radius.circular(appBorderRadius),
                      )),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageUrl: widget.displayCommodity.commodity
                            .getImageUrl()
                            .toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            appFutureBuilder<List<Listing>>(
                future: _future,
                onSuccess: (listings, context) {
                  return _FilteredListingList(
                    listings: listings,
                  );
                }),
          ],
        ));
  }
}

class _FilteredListingList extends StatefulWidget {
  final List<Listing> listings;

  _FilteredListingList({this.listings});

  @override
  State<StatefulWidget> createState() => _FilteredListingListState();
}

class _FilteredListingListState extends State<_FilteredListingList> {
  Widget _goToListing(Listing listing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushNamed(context, routes.OFFER_LISTING_INFO,
              arguments: listing)
        },
        child: ListingCard(cardListing: listing),
      ),
    );
  }

  int selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SortByWidget(
          sortItems: [
            SortByItem(
              itemTitle: "Price",
              onSelected: () {
                setState(() {
                  widget.listings.sort((a, b) => a.price.compareTo(b.price));
                  selectedChip = 0;
                });
              },
            ),
            SortByItem(
              itemTitle: "End date (price rev)",
              onSelected: () {
                setState(() {
                  widget.listings.sort((a, b) => b.price.compareTo(a.price));
                  selectedChip = 1;
                });
              },
            ),
          ],
          selectedChip: selectedChip,
        ),
        ...widget.listings.map((e) => _goToListing(e)).toList()
      ],
    );
  }
}

typedef SortByPredicate = int Function(dynamic a, dynamic b);
typedef SetStateFunc<T> = void Function(T newValue);

class SortByItem {
  final String itemTitle;
  final VoidCallback onSelected;

  SortByItem({this.itemTitle, this.onSelected});
}

class SortByWidget extends StatelessWidget {
  final List<SortByItem> sortItems;
  final int selectedChip;

  SortByWidget({
    Key key,
    @required this.sortItems,
    @required this.selectedChip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Sort by:"),
        Wrap(spacing: 3, children: [
          for (MapEntry<int, SortByItem> entry in sortItems.asMap().entries)
            ChoiceChip(
              selectedColor: Theme.of(context).primaryColor,
              label: Text(
                entry.value.itemTitle,
                style: TextStyle(
                    color: entry.key == selectedChip
                        ? emphasis2Color
                        : Colors.black),
              ),
              onSelected: (value) {
                entry.value.onSelected();
                //_onChipSelect(sortItemItem, value);
              },
              selected: entry.key == selectedChip,
            ),
        ]),
      ],
    );
  }
}
