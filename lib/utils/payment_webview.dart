import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///  This class is used to create a WebView
///  to hold the external payment page, provided by
///  the payment processor.
class PaymentWebview extends StatelessWidget {
  final String startUrl;
  final String killUrl;

  const PaymentWebview({Key key, this.startUrl, this.killUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: startUrl,
      onPageStarted: (url) {
        if (url.contains(killUrl)) {
          Navigator.pop(context);
        }
      },
    ));
  }
}
