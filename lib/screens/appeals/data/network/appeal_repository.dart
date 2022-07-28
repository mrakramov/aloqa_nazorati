import 'package:aloqa_nazorati/screens/appeals/data/model/AppealResponse.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/http_client_appeal.dart';
import 'package:aloqa_nazorati/screens/appeals/domain/appeal_repo.dart';
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
  static const appeals = "${baseUrl}my-tickets";
}

class AppealRepository extends AppealRepo {
  final HttpClientAppeal _httpClient = HttpClientAppeal();

  @override
  Future<AppealResponse> appeals(String token) async{
    try {
      final Map<String, dynamic> response =
          await _httpClient.getRequest(_Urls.appeals,token);
      return AppealResponse.fromJson(response);
    } catch (e) {
      throw ApiExceptionMapper.toErrorMessage(e);
    }
  }
}
