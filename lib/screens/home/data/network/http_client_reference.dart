import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../utils/utils.dart';

class HttpClientReference {
  HttpClientReference._privateConstructor();

  static final HttpClientReference _instance =
      HttpClientReference._privateConstructor();

  factory HttpClientReference() {
    return _instance;
  }

  Future<dynamic> getRequest(String path) async {
    http.Response response;
    try {
      response = await http.get(Uri.tryParse(path)!, headers: {
        "mobile-app-key": Strings.webApiKey,
      });
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
