import 'package:aloqa_nazorati/screens/home/data/model/reference_list_response.dart';
import 'package:aloqa_nazorati/screens/home/data/network/http_client_reference.dart';
import 'package:aloqa_nazorati/screens/home/domain/reference_repo.dart';
import 'package:flutter/foundation.dart';

import '../../../../utils/utils.dart';

class _Urls {
  static const baseUrl = "https://xn.technocorp.uz/api/";
  static const references = "${baseUrl}references";
  static const referencesServiceList = "${baseUrl}references/";
}

class ReferenceRepository extends ReferenceRepo {
  final HttpClientReference _httpClient = HttpClientReference();

  @override
  Future<List<ReferenceListResponse>> references() async {
    try {
      final List response = await _httpClient.getRequest(_Urls.references);
      return response.map((e) => ReferenceListResponse.fromJson(e)).toList();
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }

  @override
  Future<List<ReferenceListResponse>> referencesServiceList(int id) async {
    try {
      final List response = await _httpClient
          .getRequest("${_Urls.referencesServiceList}$id/children");
      return response.map((e) => ReferenceListResponse.fromJson(e)).toList();
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }
}
