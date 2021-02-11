import 'package:flutter/material.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;

final navButtonShop = NavDestButton(Icons.shopping_cart_outlined, routes.Home);
final navButtonChat = NavDestButton(Icons.chat_bubble_outline, routes.chat);
final navButtonUser =
    NavDestButton(Icons.person_outline_rounded, routes.UserInfo);

final List<NavDestButton> _userNavButtons = [
  navButtonShop,
  navButtonChat,
  navButtonUser
];
final List<NavDestButton> _sellerNavButtons = [
  navButtonShop,
  navButtonChat,
  navButtonUser
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

class MaoyiNavBar extends StatefulWidget {
  final NavDestButton currentActiveButton;
  final bool isSeller;

  MaoyiNavBar({Key key, this.currentActiveButton, this.isSeller = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MaoyiNavBarState();
}

class _MaoyiNavBarState extends State<MaoyiNavBar> {
  void _onNavigate(BuildContext context, NavDestButton button) {
    if (button.navDest != widget.currentActiveButton.navDest) {
      Navigator.pushNamed(context, button.navDest);
    }
  }

  @override
  void initState() {
    super.initState();
    _setIsSeller();
  }

  void _setIsSeller() async {
    // todo: the fetching and check for is seller here
    await Future.delayed(Duration(milliseconds: 30));
    setState(() {
      this.isSeller = true;
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
            buttons: isSeller ? _sellerNavButtons : _userNavButtons,
            currentActiveButton: widget.currentActiveButton,
            onClick: (button) => _onNavigate(context, button),
          ),
        ));
  }
}
