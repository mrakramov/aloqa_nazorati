import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/regions_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/single_appeal_response.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_send_model.dart';

import '../data/model/AppealResponse.dart';

abstract class AppealRepo {
  Future<AppealResponse> appeals(String token);
  Future<AppealCreateResponse> appealSendingMethod(
      {required AppealRequestData? model, required String? token});
  Future<List<RegionsResponse>> getRegions();
  Future<List<DistrictsResponse>> getDistricts(int? regionId);
}
