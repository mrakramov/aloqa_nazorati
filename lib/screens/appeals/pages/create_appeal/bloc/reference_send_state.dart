import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/regions_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/single_appeal_response.dart';

abstract class ReferenceSendState {
  ReferenceSendState();
}

class InitialState extends ReferenceSendState {
  InitialState();
}

class DistrictSuccessState extends ReferenceSendState {
  List<DistrictsResponse> districts;
  DistrictsResponse? currentDistrict;
  DistrictSuccessState(this.districts, this.currentDistrict);
}

class RegionsSuccessState extends ReferenceSendState {
  List<RegionsResponse> regions;
  RegionsSuccessState(this.regions);
  @override
  String toString() {
    return """${regions.first.name!.uz}
    ${regions.length}
    """;
  }
}

class SuccessState extends ReferenceSendState {
  AppealCreateResponse? response;
  SuccessState(this.response);
}

class LoadingState extends ReferenceSendState {
  bool? isLoading;
  LoadingState(this.isLoading);
}

class ErrorState extends ReferenceSendState {
  dynamic error;
  ErrorState(this.error);
}
