import 'package:aloqa_nazorati/screens/appeals/data/model/AppealResponse.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/regions_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/response_file_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/single_appeal_response.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/http_client_appeal.dart';
import 'package:aloqa_nazorati/screens/appeals/domain/appeal_repo.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_send_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../utils/utils.dart';

typedef Func = String? Function(int? regionId);

class _Urls {
  static const baseUrl = "https://xn.technocorp.uz/api/";
  static const appeals = "${baseUrl}my-tickets";
  static const referenceSending = "${baseUrl}create-ticket";
  static const regions = '${baseUrl}regions';
  static String? districts(int? regionId) {
    return '${baseUrl}region/$regionId/districts';
  }

  static const uploadFile = "${baseUrl}file-upload";
}

class AppealRepository extends AppealRepo {
  final HttpClientAppeal _httpClient = HttpClientAppeal();

  @override
  Future<AppealResponse> appeals(
    String token,
  ) async {
    try {
      final Map<String, dynamic> response = await _httpClient.getRequest(
        _Urls.appeals,
        token,
        true,
      );
      return AppealResponse.fromJson(response);
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }

  @override
  Future<AppealCreateResponse> appealSendingMethod(
      {required AppealRequestData model, required String token}) async {
    try {
      final response = await _httpClient.postRequestDio(
        url: _Urls.referenceSending,
        body: model.toJson(),
        token: token,
      );
      if (kDebugMode) {
        print(response['code']);
      }
      if (kDebugMode) {
        print(response['status']);
        print(response['data']);
      }
      return AppealCreateResponse.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('KDEBUG MODE');
      }
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }

  @override
  Future<List<DistrictsResponse>> getDistricts(int? regionId) async {
    try {
      String? districtUrl = _Urls.districts(regionId)!;
      List response = await _httpClient.getRequest(districtUrl, '', false);
      response = response.map((e) => DistrictsResponse.fromJson(e)).toList();
      return response.cast<DistrictsResponse>();
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }

  @override
  Future<List<RegionsResponse>> getRegions() async {
    try {
      List response = await _httpClient.getRequest(_Urls.regions, '', false);
      response = response.map((e) => RegionsResponse.fromJson(e)).toList();
      return response.cast<RegionsResponse>();
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }

  @override
  Future<FileUploadResponseModel> uploadFile(
      {required String? file, required String? token}) async {
    try {
      var response = await _httpClient.fileUploadPostResponse(
          url: _Urls.uploadFile, path: file, token: token);
      if (kDebugMode) {
        print(response);
      }
      return FileUploadResponseModel.fromJson(response);
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }
}
