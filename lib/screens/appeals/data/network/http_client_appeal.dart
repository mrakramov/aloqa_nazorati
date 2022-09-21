import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  }, connectTimeout: 5000, receiveTimeout: 5000));
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

// Future<String> uploadImage(File file) async {
//     String fileName = file.path.split('/').last;
//     FormData formData = FormData.fromMap({
//         "file":
//             await MultipartFile.fromFile(file.path, filename:fileName),
//     });
//     response = await dio.post("/info", data: formData);
//     return response.data['id'];
// }

  Future<dynamic> fileUploadPostResponse(
      {required String? url,
      required String? token,
      required File? file}) async {
    final Dio dio = Dio(BaseOptions(headers: {
      "mobile-app-key": Strings.webApiKey,
      "Authorization": "Bearer $token"
    }, connectTimeout: 5000, receiveTimeout: 5000));
    String fileName = file!.path.split('/').last;
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      var response = await dio.postUri(Uri.tryParse(url!)!, data: formData);
      final statusCode = response.statusCode;
      if (statusCode! >= 200 && statusCode < 299) {
        final responseString = await response.data;
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

  ///file upload post response
  // Future<dynamic> fileUploadPostResponse(
  //     {required String? url,
  //     required String? token,
  //     required String? path}) async {
  //   http.StreamedResponse response;
  //   try {
  //     var request = http.MultipartRequest("POST", Uri.tryParse(url!)!);
  //     request.headers.addAll({
  //       "mobile-app-key": Strings.webApiKey,
  //       "Authorization": "Bearer $token"
  //     });
  //     request.files.add(await http.MultipartFile.fromPath('file', path!));
  //     response = await request.send();
  //     final statusCode = response.statusCode;
  //     if (statusCode >= 200 && statusCode < 299) {
  //       final responseString = await response.stream.bytesToString();
  //       if (responseString.isEmpty) {
  //         return <dynamic>[];
  //       } else {
  //         return jsonDecode(responseString);
  //       }
  //     } else if (statusCode >= 400 && statusCode < 500) {
  //       throw ClientErrorException();
  //     } else if (statusCode >= 500 && statusCode < 600) {
  //       throw ServerErrorException();
  //     } else {
  //       throw UnknownException();
  //     }
  //   } on SocketException {
  //     throw ConnectionException();
  //   }
  // }

  ///post request using dio
  Future<dynamic> postRequestDio(
      {required String? url,
      required Map<String, dynamic> body,
      required String? token}) async {
    Response response;
    try {
      response = await _dio.postUri<Map<String, dynamic>>(Uri.tryParse(url!)!,
          data: body,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      final statusCode = response.statusCode;
      if (statusCode! >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return <dynamic>[];
        } else {
          if (kDebugMode) {
            print('http ::::---> $response');
          }
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

  Future<String> downloadFile(
      {required String url,
      required String fileName,
      required String dir,
      required String? token}) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = '$url/$fileName';
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      request.headers.add("Authorization", "Bearer $token");
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        log(file.path);
      } else {
        filePath = 'Error code: ${response.statusCode}';
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  Future<dynamic> downloadFileUsingFlutterDownloader(
      {required String? url,
      required File? savedFile,
      required String? name,
      required String? token}) async {
    try {
      final savedDir = Directory(savedFile!.path);
      late String? taskId;
      await savedDir.create().then((value) async {
        taskId = await FlutterDownloader.enqueue(
          url: url!,
          headers: {
            "Authorization": "Bearer $token"
          }, // optional: header send with url (auth token etc)
          savedDir: savedFile.path,
          showNotification:
              true, // show download progress in status bar (for Android)
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
        );
      });
      _openDownloadedFile(taskId);
      return taskId;
    } catch (e) {
      log(e);
    }
  }

  Future<bool> _openDownloadedFile(String? task) {
    if (task != null) {
      return FlutterDownloader.open(taskId: task);
    } else {
      return Future.value(false);
    }
  }

  Future<dynamic> downloadFileRequestDio(
      {required String? url,
      required File? savedFile,
      required String? name,
      required String? token}) async {
    Response response;

    try {
      log("---------------------$url");
      response = await _dio.downloadUri(
        Uri.tryParse(url!)!,
        savedFile!.path,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        onReceiveProgress: (count, total) => log('${(count / total) * 100}%'),
      );

      final statusCode = response.statusCode;
      if (statusCode! >= 200 && statusCode < 299) {
        // await FileManagementService.writeFile(
        //     response.data.readAsBytesSync(), name!)
        log("Dataaaaaa ${response.data}");
        return response.data;
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
