import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/pages/register/form_register_seller.dart';
import 'package:fishapp/widgets/BlurredImage.dart';
import 'package:fishapp/widgets/nav_widgets/common_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class RegisterSellerPage extends StatefulWidget {
  final LoginReturnRouteData returnRouteData;
  RegisterSellerPage({Key key, this.returnRouteData}) : super(key: key);

  @override
  _RegisterSellerPageState createState() => _RegisterSellerPageState();
}

class _RegisterSellerPageState extends State<RegisterSellerPage> {
  @override
  Widget build(BuildContext context) {
    return getFishappDefaultScaffold(context,
        includeTopBar: "",
        child: Stack(
          children: [
            BlurredImage(
              backgroundImage:
              AssetImage('assets/images/background-houses.jpg'),
              blurColor: softBlack.withOpacity(0.05),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          camelize(S.of(context).createSeller),
                          style: Theme.of(context).primaryTextTheme.headline1.copyWith(color: Colors.white),
                        )),
                    RegisterSellerForm(returnRoute: widget.returnRouteData),
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}