import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/single_appeal_response.dart';

abstract class AppealSendState {
  AppealSendState();
}

class InitialState extends AppealSendState {
  InitialState();
}

class DistrictSuccessState extends AppealSendState {
  List<DistrictsResponse> districts;
  DistrictsResponse? currentDistrict;
  DistrictSuccessState(this.districts, this.currentDistrict);
}

class SuccessState extends AppealSendState {
  AppealCreateResponse? response;
  SuccessState(this.response);
}

class LoadingState extends AppealSendState {
  bool? isLoading;
  LoadingState(this.isLoading);
}

class ErrorState extends AppealSendState {
  dynamic error;
  ErrorState(this.error);
}