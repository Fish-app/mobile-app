import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/services/subscription_service.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

import '../../utils/state/appstate.dart';

final navButtonShop = NavDestButton(Icons.shopping_cart_outlined, routes.HOME);
final navButtonChat = NavDestButton(Icons.chat_bubble_outline, routes.CHAT);
final navButtonUser =
    NavDestButton(Icons.person_outline_rounded, routes.USER_INFO);
final navButtonNewOfferListing = NavDestButton(Icons.list, routes.NEW_LISTING);
final navButtonNewBuyRequest =
    NavDestButton(Icons.list, routes.NEW_BUY_REQUEST);

final List<NavDestButton> _userNavButtons = [
  navButtonShop,
  navButtonChat,
  navButtonUser,
  navButtonNewBuyRequest
];
final List<NavDestButton> _sellerNavButtons = [
  navButtonShop,
  navButtonChat,
  navButtonUser,
  navButtonNewOfferListing
];

class FloatingNavBar extends StatelessWidget {
  final List<NavDestButton> buttons;
  final Function(NavDestButton) onClick;
  final NavDestButton currentActiveButton;

  const FloatingNavBar(
      {Key key, this.buttons, this.onClick, this.currentActiveButton})
      : super(key: key);

  final Color _buttonActiveIconColor = Colors.orange;
  final Color _buttonActiveBgColor = const Color(0xFF555555);

  final Color _buttonInActiveIconColor = Colors.white;
  final Color _buttonInActiveBgColor = Colors.black;

  final double _buttonIconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
      //width: MediaQuery.of(context).size.width * 0.9,
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: buttons.map((navButton) {
          var isActive = navButton.navDest == currentActiveButton.navDest;
          var iconTheme = isActive
              ? Theme.of(context).bottomNavigationBarTheme.selectedIconTheme
              : Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme;
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 11),
              child: GestureDetector(
                  onTap: () => onClick(navButton),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedItemColor
                            : Theme.of(context)
                                .bottomNavigationBarTheme
                                .unselectedItemColor,
                        shape: BoxShape.circle),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(navButton.iconData,
                            size: iconTheme.size, color: iconTheme.color)

                        // ),
                        ),
                  )));
        }).toList(),
      ),
    );
  }
}

class NavDestButton {
  final IconData iconData;
  final String navDest;

  NavDestButton(this.iconData, this.navDest);
}

class FishappNavBar extends StatefulWidget {
  final NavDestButton currentActiveButton;
  final bool isSeller;

  FishappNavBar({Key key, this.currentActiveButton, this.isSeller = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FishappNavBarState();
}

class _FishappNavBarState extends State<FishappNavBar> {
  void _onNavigate(BuildContext context, NavDestButton button) {
    switch (button.navDest) {
      case routes.NEW_LISTING:
        _isSubscriptionActive().then((value) => {
              if (!value)
                {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) =>
                          _buildAlertDialog(context))
                }
              else if (_isNotCurrent(button) && value)
                {Navigator.pushNamed(context, button.navDest)}
            });
        break;
      case routes.NEW_BUY_REQUEST:
        if (_isNotCurrent(button)) {
          Navigator.pushNamed(context, button.navDest);
        }
        break;
      default:
        if (_isNotCurrent(button)) {
          Navigator.pushNamed(context, button.navDest);
        }
    }
  }

  Future<bool> _isSubscriptionActive() async {
    User user = Provider.of<AppState>(context, listen: false)?.user;
    bool isActive = await SubscriptionService().getIsSubscriptionValid(user.id);
    return isActive;
  }

  bool _isNotCurrent(NavDestButton button) {
    bool current;
    if (button.navDest != widget.currentActiveButton.navDest) {
      current = true;
    } else {
      current = false;
    }
    return current;
  }

  @override
  void initState() {
    super.initState();
    _setIsSeller();
  }

  void _setIsSeller() async {
    await Future.delayed(Duration(milliseconds: 30));
    setState(() {
      this.isSeller = Provider.of<AppState>(context, listen: false).isSeller();
    });
  }

  bool isSeller = false;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "BottomNavBar",
        child: Center(
          heightFactor: 1.4,
          child: FloatingNavBar(
            buttons: Provider.of<AppState>(context, listen: false).isSeller()
                ? _sellerNavButtons
                : _userNavButtons,
            currentActiveButton: widget.currentActiveButton,
            onClick: (button) => _onNavigate(context, button),
          ),
        ));
  }

  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(camelize(S.of(context).noSubscription)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(capitalize(S.of(context).errorNotSubscribed)),
          StandardButton(
              buttonText: capitalize(S.of(context).subscribe),
              onPressed: () {
                Navigator.pushNamed(context, routes.SUBSCRIPTION_INFO);
              })
        ],
      ),
      actions: [
        new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(capitalize(S.of(context).close)))
      ],
    );
  }
}
