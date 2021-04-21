import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        if (url == killUrl) {
          Navigator.pop(context);
        }
      },
    ));
  }
}
