import 'package:aloqa_nazorati/screens/auth/data/model/UserDataResponse.dart';
import 'package:aloqa_nazorati/screens/auth/data/network/http_client_auth.dart';
import 'package:aloqa_nazorati/screens/auth/domain/auth_repo.dart';
import 'package:aloqa_nazorati/screens/home/data/model/reference_list_response.dart';
import 'package:aloqa_nazorati/screens/home/data/network/http_client_reference.dart';
import 'package:aloqa_nazorati/screens/home/domain/reference_repo.dart';
import 'package:flutter/foundation.dart';

import '../../../../utils/utils.dart';

class _Urls {
  static const baseUrl = "https://xn.technocorp.uz/api/";
  static const user = "${baseUrl}one-id/432fdsfHHDSFG213__LL-123QWE";
}

class AuthRepository extends AuthRepo {
  final HttpClientAuth _httpClient = HttpClientAuth();

  @override
  Future<UserDataResponse> userData(String code) async {
    try {
      final Map<String, dynamic> response =
          await _httpClient.getRequest("${_Urls.user}?code=$code");
      return UserDataResponse.fromJson(response);
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }
}
