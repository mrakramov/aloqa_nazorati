import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/utils.dart';

class HttpClientAppeal {
  HttpClientAppeal._privateConstructor();
  static final HttpClientAppeal _instance =
      HttpClientAppeal._privateConstructor();

  factory HttpClientAppeal() {
    return _instance;
  }
  final Dio _dio = Dio(BaseOptions(headers: {
    "mobile-app-key": Strings.webApiKey,
  }));
  Future<dynamic> getRequest(
    String path,
    String token,
    bool? shouldToken,
  ) async {
    http.Response response;
    if (kDebugMode) {
      print(path);
    }
    try {
      response = await http.get(
        Uri.tryParse(path)!,
        headers: {
          "mobile-app-key": Strings.webApiKey,
          if (shouldToken!) "Authorization": "Bearer $token"
        },
      );
      log(response.body);
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

  Future<dynamic> postRequest(
      {required String? path,
      required Map<String, dynamic> body,
      required String? token}) async {
    http.Response response;
    try {
      response = await http.post(Uri.tryParse(path!)!,
          body: jsonEncode(body),
          headers: {
            "mobile-app-key": Strings.webApiKey,
            "Authorization": "Bearer $token"
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

  ///file upload post response
  Future<dynamic> fileUploadPostResponse(
      {required String? url,
      required String? token,
      required String? path}) async {
    http.StreamedResponse response;
    try {
      var request = http.MultipartRequest("POST", Uri.tryParse(url!)!);
      request.headers.addAll({
        "mobile-app-key": Strings.webApiKey,
        "Authorization": "Bearer $token"
      });
      request.files.add(await http.MultipartFile.fromPath('file', path!));
      response = await request.send();
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        final responseString = await response.stream.bytesToString();
        if (responseString.isEmpty) {
          return <dynamic>[];
        } else {
          return jsonDecode(responseString);
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

  ///post request using dio
  Future<dynamic> postRequestDio(
      {required String? url,
      required Map<String, dynamic> body,
      required String? token}) async {
    Response response;
    try {
      response = await _dio.postUri(Uri.tryParse(url!)!,
          data: body,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      final statusCode = response.statusCode;
      if (statusCode! >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return <dynamic>[];
        } else {
          return response.data;
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
