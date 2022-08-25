import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_response_model_for_create_ticket.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/response_file_model.dart';

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
  AppealResponseModelForCreateTicket? response;
  SuccessState(this.response);
}

class FileUploadState extends AppealSendState {
  List<FileUploadResponseModel?> file;
  FileUploadState({required this.file});
}

class LoadingState extends AppealSendState {
  bool? isLoading;
  LoadingState(this.isLoading);
}

class ErrorState extends AppealSendState {
  dynamic error;
  ErrorState(this.error);
}
