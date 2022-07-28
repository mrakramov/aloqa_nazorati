import 'package:aloqa_nazorati/screens/appeals/data/model/AppealResponse.dart';

abstract class AppealState {
  AppealState();
}

class InitialState extends AppealState {
  InitialState();
}

class SuccessState extends AppealState {
  final AppealResponse response;

  SuccessState(this.response);
}

class UploadingState extends AppealState {
  final bool isLoading;

  UploadingState(this.isLoading);
}

class ErrorState extends AppealState {
  final dynamic error;
  ErrorState(this.error);
}
