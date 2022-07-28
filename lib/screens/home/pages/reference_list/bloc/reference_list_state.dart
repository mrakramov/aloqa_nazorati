import 'package:aloqa_nazorati/screens/home/data/model/reference_list_response.dart';

abstract class ReferenceListState {
  ReferenceListState();
}

class InitialState extends ReferenceListState {
  InitialState();
}

class SuccessState extends ReferenceListState {
  final List<ReferenceListResponse> response;

  SuccessState(this.response);
}

class UploadingState extends ReferenceListState {
  final bool isLoading;

  UploadingState(this.isLoading);
}

class ErrorState extends ReferenceListState {
  final dynamic error;
  ErrorState(this.error);
}
