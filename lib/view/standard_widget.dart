import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';

import 'flutterwave_in_app_browser.dart';

class StandardPaymentWidget extends StatefulWidget {
  final String webUrl;

  StandardPaymentWidget({required this.webUrl});

  @override
  _StandardPaymentWidgetAppState createState() =>
      new _StandardPaymentWidgetAppState();
}

class _StandardPaymentWidgetAppState extends State<StandardPaymentWidget>
    implements TransactionCallBack {
  var options = InAppBrowserClassSettings(
    browserSettings: InAppBrowserSettings(
      hideTitleBar: false,
      toolbarTopFixedTitle: 'Skrept Checkout',
      hideDefaultMenuItems: true,
      hideToolbarTop: false,
      hideUrlBar: true,
    ),
    webViewSettings: InAppWebViewSettings(javaScriptEnabled: true),
  );

  @override
  void initState() {
    super.initState();
    final browser = FlutterwaveInAppBrowser(callBack: this);
    browser.openUrlRequest(
        urlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.webUrl))),
        settings: options);
  }

  @override
  onTransactionComplete(ChargeResponse? chargeResponse) {
    Navigator.pop(context, chargeResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      backgroundColor: Colors.white,
    );
  }
}
