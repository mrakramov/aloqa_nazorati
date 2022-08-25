import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_list_responses/single_appeal_response_model.dart';

abstract class AppealSingleResponseState {}

class InitialSingleState extends AppealSingleResponseState {}

class LoadingState extends AppealSingleResponseState {
  bool? isLoading;
  LoadingState(this.isLoading);
}

class SuccesState extends AppealSingleResponseState {
  SingleAppealResponseModel? appeal;
  SuccesState(this.appeal);
}

class ErrorState extends AppealSingleResponseState {
  Object? error;
  ErrorState(this.error);
}
