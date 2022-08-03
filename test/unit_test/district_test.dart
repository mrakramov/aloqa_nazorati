import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/http_client_appeal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppealRepository? repo;
  HttpClientAppeal? appeal;
  setUp(() {
    appeal = HttpClientAppeal();
    repo = AppealRepository();
  });
  tearDown(() {});
  group('desc', () {
    test('desc', () async {
      List<DistrictsResponse> data = await repo!.getDistricts(10);
      expect(data.first, isA<DistrictsResponse>());
    });
  });

  test('appeal http client', () async {
    var data = await appeal!.getRequest(
        'https://xn.technocorp.uz/api/region/10/districts', '', false);
    if (kDebugMode) {
      print(data.toString());
    }
    expect(data.isNotEmpty, true);
  });
}
