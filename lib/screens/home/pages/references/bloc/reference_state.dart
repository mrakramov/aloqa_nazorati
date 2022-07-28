import 'package:aloqa_nazorati/screens/home/data/model/reference_list_response.dart';

abstract class ReferenceState {
  ReferenceState();
}

class InitialState extends ReferenceState {
  InitialState();
}

class SuccessState extends ReferenceState {
  final List<ReferenceListResponse> response;

  SuccessState(this.response);
}

class UploadingState extends ReferenceState {
  final bool isLoading;

  UploadingState(this.isLoading);
}

class ErrorState extends ReferenceState {
  final dynamic error;
  ErrorState(this.error);
}
