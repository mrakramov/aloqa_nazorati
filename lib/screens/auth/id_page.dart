import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IdGovPage extends StatefulWidget {
  const IdGovPage({Key? key}) : super(key: key);

  @override
  State<IdGovPage> createState() => _IdGovPageState();
}

class _IdGovPageState extends State<IdGovPage> {
  String redirectUrl = "";
  String url = "";

  @override
  void initState() {
    super.initState();
    redirectUrl =
        "https://xn.technocorp.uz/api/one-id/432fdsfHHDSFG213__LL-123QWE";
    url = "https://sso2.egov.uz:8443/sso/"
        "oauth/Authorization.do?response_type="
        "one_code&client_id=gis_xn_mobile&redirect_uri=$redirectUrl"
        "&scope=gis_xn_mobile&"
        "state=eyJtZXRob2QiOiJJRFBXIn0=";

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          onPageStarted: (url) {
            setState(() {
              if (url.contains("$redirectUrl?code=")) {
                if (kDebugMode) {}
              }
            });
          }),
    );
  }
}
