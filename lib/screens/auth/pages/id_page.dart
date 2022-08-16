import 'dart:convert';
import 'dart:io';

import 'package:aloqa_nazorati/screens/auth/data/network/auth_repository.dart';
import 'package:aloqa_nazorati/screens/auth/pages/bloc/auth_bloc.dart';
import 'package:aloqa_nazorati/screens/auth/pages/bloc/auth_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main/main_page.dart';

class IdGovPage extends StatefulWidget {
  const IdGovPage({Key? key}) : super(key: key);

  @override
  State<IdGovPage> createState() => _IdGovPageState();
}

class _IdGovPageState extends State<IdGovPage> {
  String redirectUrl = "";
  String url = "";
  final AuthBloc _bloc = AuthBloc(AuthRepository());

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessState) {
            Prefs.save("token", state.response.token!);
            Prefs.save("userData", jsonEncode(state.response.data));

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          }
        },
        bloc: _bloc,
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            return WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: url,
                onPageStarted: (url) {
                  if (url.contains("$redirectUrl?code=")) {
                    var i = url.indexOf("code=");
                    var i2 = url.indexOf("&state");
                    var code = url.substring(i + 5, i2);
                    if (kDebugMode) {
                      print(code);
                    }
                    _bloc.userData(code);
                  }
                });
          },
        ),
      ),
    );
  }
}
