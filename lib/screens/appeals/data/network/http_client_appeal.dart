import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../../utils/utils.dart';

class HttpClientAppeal {
  HttpClientAppeal._privateConstructor();

  static final HttpClientAppeal _instance =
      HttpClientAppeal._privateConstructor();

  factory HttpClientAppeal() {
    return _instance;
  }

  Future<dynamic> getRequest(String path, String token) async {
    Response response;
    try {
      response = await get(
        Uri.tryParse(path)!,
        headers: {
          "mobile-app-key": Strings.webApiKey,
          "Authorization": "Bearer $token"
        },
      );
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.body.isEmpty) {
          return <dynamic>[];
        } else {
          return jsonDecode(response.body);
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } on SocketException {
      throw ConnectionException();
    }
  }
}
